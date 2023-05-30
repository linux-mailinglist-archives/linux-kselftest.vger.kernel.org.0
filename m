Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D490715FD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 14:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjE3Md3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjE3MdO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 08:33:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88707E53;
        Tue, 30 May 2023 05:32:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C5B0121ADF;
        Tue, 30 May 2023 12:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685449893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4r2dKrL0esFEC4r6mNqOb67BdMVIEvOCW/VAhqjUWc=;
        b=h5MmXUfhWOwZcrwe7NZWvEHK+/tpbD3lT5ESYjsR/fIPtu0KHvMknKC6cW3VNZ5Ptrf73A
        RiUbbCXvcUxaLhr/974N3UlCeCE2fWfJkosgaAY6FY4bGoIG0EyQLRKSHjbyFGraUOfq4b
        hYmHNi5oR+WcaQkUO0odCa4BhJs352E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685449893;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4r2dKrL0esFEC4r6mNqOb67BdMVIEvOCW/VAhqjUWc=;
        b=ywPZow5zX5ejCdKMprk/QdgpbZJt1V+/FKo3w6H4WtoQU4el7u8hpvk/rQx1kFoRAHOfjY
        YB+M+lY49OFM8bAg==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 528F92C141;
        Tue, 30 May 2023 12:31:33 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 3F3164A037E; Tue, 30 May 2023 14:31:33 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] selftests/nolibc: add new gettimeofday test cases
In-Reply-To: <ZHXmbNg4BdJNd4cO@1wt.eu> (Willy Tarreau's message of "Tue, 30
        May 2023 14:05:00 +0200")
References: <cover.1685428087.git.falcon@tinylab.org>
        <bfc3dba52300dcce03ae1c7c41f2bb8984cf459b.1685428087.git.falcon@tinylab.org>
        <96f1134d-ce6e-4d82-ae00-1cd4038809c4@t-8ch.de>
        <ZHXmbNg4BdJNd4cO@1wt.eu>
X-Yow:  I represent a sardine!!
Date:   Tue, 30 May 2023 14:31:33 +0200
Message-ID: <mvmedmyatlm.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mai 30 2023, Willy Tarreau wrote:

> On Tue, May 30, 2023 at 12:59:31PM +0200, Thomas Weißschuh wrote:
>> On 2023-05-30 14:37:49+0800, Zhangjin Wu wrote:
>> > These 3 test cases are added to cover the normal using scenes of
>> > gettimeofday().
>> > 
>> > They have been used to trigger and fix up such issue:
>> > 
>> >     nolibc-test.c:(.text.gettimeofday+0x54): undefined reference to `__aeabi_ldivmod'
>> > 
>> > This issue happens while there is no "unsigned int" conversion in the
>> > new clock_gettime / clock_gettime64 syscall path of gettimeofday():
>> > 
>> >     tv->tv_usec = ts.tv_nsec / 1000;
>> > 
>> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
>> > ---
>> >  tools/testing/selftests/nolibc/nolibc-test.c | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> > 
>> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
>> > index 8ba8c2fc71a0..20d184da9a2b 100644
>> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
>> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
>> > @@ -533,6 +533,8 @@ static int test_stat_timestamps(void)
>> >   */
>> >  int run_syscall(int min, int max)
>> >  {
>> > +	struct timeval tv;
>> > +	struct timezone tz;
>> >  	struct stat stat_buf;
>> >  	int euid0;
>> >  	int proc;
>> > @@ -588,6 +590,9 @@ int run_syscall(int min, int max)
>> >  		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
>> >  		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
>> >  		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
>> > +		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
>> > +		CASE_TEST(gettimeofday_tz);   EXPECT_SYSZR(1, gettimeofday(NULL, &tz)); break;
>> 
>> Calling gettimeofday(NULL, ...) will actually segfault on glibc.
>> It works when calling through the VDSO, but not the logic in glibc
>> itself, which is guess is allowed by POSIX.
>
> Then that's shocking, because the man page says:
>
>        If either tv or tz is NULL, the corresponding structure is not  set  or
>        returned.   (However, compilation warnings will result if tv is NULL.)
>
> I'd expect glibc to at least support what'd documented in the man
> page :-/

The manual page is not part of glibc.  Neither the glibc documentation
nor the POSIX spec has ever supported NULL for the first argument.  The
generic POSIX implementation in glibc originally returned EINVAL for
that case, though.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
