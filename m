Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2575C1B6BEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 05:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgDXDZe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Apr 2020 23:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725884AbgDXDZe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Apr 2020 23:25:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F87C09B044;
        Thu, 23 Apr 2020 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=YaxbrobIPhmJ6gAJP/7erNrWrP4SniDRb5VPnVVlvrM=; b=R40ftRyiYHQhezok0fWd3uAaJ6
        HjOjNahWvCThQc8W6sU7NiIReMX3FP9t2ds4KhylKlmqwv+s/BI+5ZwPoa6XNvI91wiDX1kXV+OXo
        Sqp7iEXJ6DBCLO3y8/PR3tcEWiuTxLOnr6lpjT0nTSimJpQRmRRfvYBdORuroFB70PiorEyFbdAlq
        dfa7oiqBI80kDMBh4t6NkNf9MKUm5dYaI0baOM5Rro1n+sedS3ZLziEKL9lXSWxZgA2SdF0TAmSPm
        VQpCGCMaJab76XPiISmHy9ocOIg02JaKGSsKSyD5AzIrrW/nWglKR8jfeqIk8xJS0jU7e3te5PaBs
        6fMD2lVA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRoy1-0004M0-9R; Fri, 24 Apr 2020 03:25:29 +0000
Subject: Re: [PATCH] selftests: add build/cross-build dependency check script
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        bamv2005@gmail.com, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200414212208.21667-1-skhan@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <374866ac-4519-f367-bdc6-ec8d0c1b6347@infradead.org>
Date:   Thu, 23 Apr 2020 20:25:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414212208.21667-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 4/14/20 2:22 PM, Shuah Khan wrote:
> -CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(MOUNT_CFLAGS)
> -LDLIBS += $(MOUNT_LDLIBS)
> +CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(VAR_CFLAGS)
> +LDLIBS += $(VAR_LDLIBS)


(1) Can that series of ../../../.. be replaced by $(objtree)?
If so, that would be much cleaner IMO.

(2) I can't find anything that checks that ../../../../usr/include exists
(or has been installed via 'make headers_install').  Or anything that
requires that CONFIG_HEADERS_INSTALL be set/enabled.  Well, other than
a Makefile error, but that's not a nice way to find out.

Preferably we would have some Kconfig check/enforcement or at least some
documentation.

Thoughts?

thanks.
-- 
~Randy

