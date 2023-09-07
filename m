Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CECB797EDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 00:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbjIGWzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 18:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbjIGWzA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 18:55:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3B1BD7;
        Thu,  7 Sep 2023 15:54:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B1AC433C7;
        Thu,  7 Sep 2023 22:54:54 +0000 (UTC)
Date:   Thu, 7 Sep 2023 18:55:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        broonie@kernel.org, naresh.kamboju@linaro.org,
        anders.roxell@linaro.org, arnd@arndb.de
Subject: Re: [PATCH] selftests/user_events: Fix failures when user_events is
 not installed
Message-ID: <20230907185507.7928b589@gandalf.local.home>
In-Reply-To: <20230907223536.731-1-beaub@linux.microsoft.com>
References: <20230907223536.731-1-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu,  7 Sep 2023 22:35:36 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> diff --git a/tools/testing/selftests/user_events/user_events_selftests.h b/tools/testing/selftests/user_events/user_events_selftests.h
> new file mode 100644
> index 000000000000..72692e62c709
> --- /dev/null
> +++ b/tools/testing/selftests/user_events/user_events_selftests.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _USER_EVENTS_SELFTESTS_H
> +#define _USER_EVENTS_SELFTESTS_H
> +
> +#include <sys/types.h>
> +#include <sys/mount.h>
> +#include <unistd.h>
> +#include <errno.h>
> +
> +#include "../kselftest.h"
> +
> +static inline bool tracefs_enabled(char **message, bool *fail)
> +{
> +	int fd;
> +
> +	*message = "";
> +	*fail = false;
> +
> +	/* Ensure tracefs is installed */
> +	fd = open("/sys/kernel/tracing", O_RDONLY);

Instead of opening the directory, I believe that "stat()" is the preferred
method of testing existence.

> +
> +	if (fd == -1) {
> +		*message = "Tracefs is not installed";
> +		return false;
> +	}
> +
> +	close(fd);
> +
> +	/* Ensure mounted tracefs */
> +	fd = open("/sys/kernel/tracing/README", O_RDONLY);
> +
> +	if (fd == -1 && errno == ENOENT) {
> +		if (mount(NULL, "/sys/kernel/tracing", "tracefs", 0, NULL) != 0) {
> +			*message = "Cannot mount tracefs";
> +			*fail = true;
> +			return false;
> +		}
> +
> +		fd = open("/sys/kernel/tracing/README", O_RDONLY);

Same here, unless you want to make sure you can also read it.

> +	}
> +
> +	if (fd == -1) {
> +		*message = "Cannot access tracefs";
> +		*fail = true;
> +		return false;
> +	}
> +
> +	close(fd);
> +
> +	return true;
> +}
> +
> +static inline bool user_events_enabled(char **message, bool *fail)
> +{
> +	int fd;
> +
> +	*message = "";
> +	*fail = false;
> +
> +	if (getuid() != 0) {
> +		*message = "Must be run as root";
> +		*fail = true;
> +		return false;
> +	}
> +
> +	if (!tracefs_enabled(message, fail))
> +		return false;
> +
> +	/* Ensure user_events is installed */
> +	fd = open("/sys/kernel/tracing/user_events_data", O_RDONLY);

ditto.

-- Steve

> +
> +	if (fd == -1) {
> +		switch (errno) {
> +		case ENOENT:
> +			*message = "user_events is not installed";
> +			return false;
> +
> +		default:
> +			*message = "Cannot access user_events_data";
> +			*fail = true;
> +			return false;
> +		}
> +	}
> +
> +	close(fd);
> +
> +	return true;
> +}
> +
> +#define USER_EVENT_FIXTURE_SETUP(statement) do { \
> +	char *message; \
> +	bool fail; \
> +	if (!user_events_enabled(&message, &fail)) { \
> +		if (fail) { \
> +			TH_LOG("Setup failed due to: %s", message); \
> +			ASSERT_FALSE(fail); \
> +		} \
> +		SKIP(statement, "Skipping due to: %s", message); \
> +	} \
> +} while (0)
> +
> +#endif /* _USER_EVENTS_SELFTESTS_H */
> 
> base-commit: 9b1db732866bee060b9bca9493e5ebf5e8874c48

