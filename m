Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE76D77FD0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353435AbjHQRdB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 13:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354022AbjHQRcb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 13:32:31 -0400
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 10:32:29 PDT
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56F30D8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 10:32:29 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RRX3q1CXtzMq87q;
        Thu, 17 Aug 2023 17:26:31 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RRX3p5SmDzMppKN;
        Thu, 17 Aug 2023 19:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692293191;
        bh=jfuq98ImyNnxGl2U9jUTns/Ad5VkKMZiGXUI1Nhj+Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yNgLQLYAmXqtLQet+wot+q9Ls0sEjmuVGgx4dqbqgydHaCdXNtFlpp2X0Y1nrrJZP
         ATdiSb5zst9LJ5yCuxBz58iQmTKLw2BwWkWj35WE6qf8WpESy3vTJZV1uYoZ9pxbba
         jdJCc4viaN9S9eH/4Giit2IN0KRu1AkK0SWZmwTk=
Date:   Thu, 17 Aug 2023 19:26:25 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH 2/2] selftests: landlock: skip all tests without landlock
 syscall
Message-ID: <20230817.eubeif7chuTh@digikod.net>
References: <20230809170435.1312162-1-andre.przywara@arm.com>
 <20230809170435.1312162-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809170435.1312162-3-andre.przywara@arm.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 06:04:35PM +0100, Andre Przywara wrote:
> "landlock" is a relatively new syscall, and most defconfigs do not enable
> it (yet). On systems without this syscall available, the selftests fail
> at the moment, instead of being skipped.
> 
> Check the availability of the landlock system call before executing each
> test, and skip the rest of the tests if we get an ENOSYS back.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  tools/testing/selftests/landlock/base_test.c | 27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 1e3b6de57e80e..c539cec775fba 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -21,12 +21,20 @@
>  #define O_PATH 010000000
>  #endif
>  
> +static bool has_syscall(void)
> +{
> +	return landlock_create_ruleset(NULL, 0, 0) == -1 && errno != ENOSYS;
> +}

We could replace most TEST*(name) macros with
TEST*_LANDLOCK(name, minimal_abi_version).

These TEST*_LANDLOCK() macros would simply prepend a header like this:

const int abi_version = landlock_create_ruleset(NULL, 0,
	LANDLOCK_CREATE_RULESET_VERSION);
if (abi_version < minimal_abi_version)
	SKIP(return, "only supported since Landlock ABI %d (instead of
		%d)", minimal_abi_version, abi_version);

These helpers need to be defined in common.h to be easily usable everywhere.

> +
>  TEST(inconsistent_attr)
>  {
>  	const long page_size = sysconf(_SC_PAGESIZE);
>  	char *const buf = malloc(page_size + 1);
>  	struct landlock_ruleset_attr *const ruleset_attr = (void *)buf;
>  
> +	if (!has_syscall())
> +		SKIP(return, "landlock syscall not available");
> +
>  	ASSERT_NE(NULL, buf);
>  
>  	/* Checks copy_from_user(). */
> @@ -75,6 +83,10 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> +
> +	if (!has_syscall())
> +		SKIP(return, "landlock syscall not available");
> +
>  	ASSERT_NE(0, landlock_create_ruleset(NULL, 0,
>  					     LANDLOCK_CREATE_RULESET_VERSION));
>  
> @@ -107,6 +119,9 @@ TEST(create_ruleset_checks_ordering)
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
>  
> +	if (!has_syscall())
> +		SKIP(return, "landlock syscall not available");
> +
>  	/* Checks priority for invalid flags. */
>  	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0, invalid_flag));
>  	ASSERT_EQ(EINVAL, errno);
> @@ -153,6 +168,9 @@ TEST(add_rule_checks_ordering)
>  	const int ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>  
> +	if (!has_syscall())
> +		SKIP(return, "landlock syscall not available");
> +
>  	ASSERT_LE(0, ruleset_fd);
>  
>  	/* Checks invalid flags. */
> @@ -200,6 +218,9 @@ TEST(restrict_self_checks_ordering)
>  	const int ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>  
> +	if (!has_syscall())
> +		SKIP(return, "landlock syscall not available");
> +
>  	ASSERT_LE(0, ruleset_fd);
>  	path_beneath_attr.parent_fd =
>  		open("/tmp", O_PATH | O_NOFOLLOW | O_DIRECTORY | O_CLOEXEC);
> @@ -240,6 +261,9 @@ TEST(ruleset_fd_io)
>  	int ruleset_fd;
>  	char buf;
>  
> +	if (!has_syscall())
> +		SKIP(return, "landlock syscall not available");
> +
>  	drop_caps(_metadata);
>  	ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> @@ -267,6 +291,9 @@ TEST(ruleset_fd_transfer)
>  	pid_t child;
>  	int status;
>  
> +	if (!has_syscall())
> +		SKIP(return, "landlock syscall not available");
> +
>  	drop_caps(_metadata);
>  
>  	/* Creates a test ruleset with a simple rule. */
> -- 
> 2.25.1
> 
