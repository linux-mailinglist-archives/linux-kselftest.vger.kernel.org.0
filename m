Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2558E49C416
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 08:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiAZHNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 02:13:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38844 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbiAZHNO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 02:13:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AFC0F212BF;
        Wed, 26 Jan 2022 07:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643181192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IP+RMWpt0uTAbiL4Z8Uvd4U+E5TBgChxKWU4BBtSYdg=;
        b=l9qnLpgP7t/izLAl/CUfzO9Smi8X+J19SKmnVlg4lvq8P2fmotX4pv6XE2OlrowlTs82qB
        xSWUUo6CElgFjw5ggEZGP96/vLdrgKPqKbzCa4TXfyVtu+KA+4JoHs1niFMGHHP1kvlJQ5
        eANbAHj0ke31iTT2T5Z/vDS4+pufPOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643181192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IP+RMWpt0uTAbiL4Z8Uvd4U+E5TBgChxKWU4BBtSYdg=;
        b=WvA6baKVkHVONrRGzX/Msk1aNg9LrmBP0cVX+E+s8nwct/ddzxUX7IQ3KbHdx1nWFo2O6X
        NnnfPXvnMSyjnmBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A16E13B56;
        Wed, 26 Jan 2022 07:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sd8iGIj08GFiBQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 07:13:12 +0000
Date:   Wed, 26 Jan 2022 08:13:10 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "aleksei.kodanev@bell-sw.com" <aleksei.kodanev@bell-sw.com>
Subject: Re: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
Message-ID: <YfD0hiUSf40jX82d@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1146337d-718e-a369-1012-224f06bc9c2f@linuxfoundation.org>
 <61F0D9F7.1080200@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61F0D9F7.1080200@fujitsu.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

> on 2022/1/26 4:33, Shuah Khan wrote :
> > On 12/15/21 2:56 AM, Yang Xu wrote:
> >> Since kernel commit 43209ea2d17a ("zram: remove max_comp_streams
> >> internals"), zram has
> >> switched to per-cpu streams. Even kernel still keep this interface for
> >> some reasons, but
> >> writing to max_comp_stream doesn't take any effect. So remove it.

> > I get that max_comp_stream doesn't do anything since this referenced
> > commit. Don't we need this test on older kernels since older kernels
> > still support max_comp_stream?

> I read the following info from kernel selftest documentation
> https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html

> "The kernel contains a set of “self tests” under the 
> tools/testing/selftests/ directory. These are intended to be small tests 
> to exercise individual code paths in the kernel. Tests are intended to 
> be run after building, installing and booting a kernel."

> So, we can build older kernel(use older kernel source) if we want to 
> test older kernel.

> IMO, kernel selftest is different from other testsuit(ie ltp, this 
> shuould think about api changes because ltp may test on different kernel).
Yes, that's how I understand the difference with approach of in kselftest - the
kernel tree testsuite and LTP - the out-of-tree testsuite.

Kind regards,
Petr

> Also cc ltp co-maintainer Petr

> Or, did I miss something?

> Best Regards
> Yang Xu



> > thanks,
> > -- Shuah
