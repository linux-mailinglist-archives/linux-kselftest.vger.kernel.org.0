Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523D971F88F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 04:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjFBCmF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 22:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjFBCmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 22:42:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49631192;
        Thu,  1 Jun 2023 19:42:03 -0700 (PDT)
X-QQ-mid: bizesmtp67t1685673718t57gxjvm
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Jun 2023 10:41:57 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: rZJGTgY0+YPwgiakv+THh63hc5GL5wrSfdcmfDhOS6QGyKlpj/pA1lPZrNBJn
        S2PuA7MPx5NA7C1rfVlK3kj2oDOohD86hqt9rTiKaOmnIgqgVP1kADXNm87bE0Qjkw65H4U
        Nk9O/OhkDoD3LA8P7zp7FuOKWxCdZpUNdmU7cvTZ6vv60Gb06wmNjrL7npQ2VQtR77Ms9bn
        FhHFtI3iToYyuF/K5irzIZWEtJQ83vw6ixMp0RFD6a39kGH8a3EItulQB9mugw/QJIGni7K
        YVEhSnLbvNOgOu9eKMAAAc9ZnX4ISwso9Qu6n+Y3Htb7DVp9u9YwaMT+rHmhp9T5wkgsOuv
        zjad4G8I8vZgaCL4E70g98xApxdF/8qQqRtJWpxFMb+MOMgF8izKZjerhpXPQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6459984539969045256
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, thomas@t-8ch.de, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/nolibc: test_fork: fix up duplicated print
Date:   Fri,  2 Jun 2023 10:41:57 +0800
Message-Id: <20230602024157.11151-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <61bdfe7bacebdef8aa9195f6f2550a5b0d33aab3.1685426545.git.falcon@tinylab.org>
References: <61bdfe7bacebdef8aa9195f6f2550a5b0d33aab3.1685426545.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

What about this one for 2023xxxx-nolibc-rv32+stkp6?

@Thomas, welcome your Reviewed-by If it is ok for you ;-)

Best regards,
Zhangjin

> running nolibc-test with glibc on x86_64 got such print issue:
> 
>     29 execve_root = -1 EACCES                                       [OK]
>     30 fork30 fork = 0                                                      [OK]
>     31 getdents64_root = 712                                         [OK]
> 
> The fork test case has three printf calls:
> 
>     (1) llen += printf("%d %s", test, #name);
>     (2) llen += printf(" = %d %s ", expr, errorname(errno));
>     (3) llen += pad_spc(llen, 64, "[FAIL]\n"); --> vfprintf()
> 
> In the following scene, the above issue happens:
> 
>     (a) The parent calls (1)
>     (b) The parent calls fork()
>     (c) The child runs and shares the print buffer of (1)
>     (d) The child exits, flushs the print buffer and closes its own stdout/stderr
>         * "30 fork" is printed at the first time.
>     (e) The parent calls (2) and (3), with "\n" in (3), it flushs the whole buffer
>         * "30 fork = 0 ..." is printed
> 
> Therefore, there are two "30 fork" in the stdout.
> 
> Between (a) and (b), if flush the stdout (and the sterr), the child in
> stage (c) will not be able to 'see' the print buffer.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 7de46305f419..88323a60aa4a 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -486,7 +486,13 @@ static int test_getpagesize(void)
>  static int test_fork(void)
>  {
>  	int status;
> -	pid_t pid = fork();
> +	pid_t pid;
> +
> +	/* flush the printf buffer to avoid child flush it */
> +	fflush(stdout);
> +	fflush(stderr);
> +
> +	pid = fork();
>  
>  	switch (pid) {
>  	case -1:
> -- 
> 2.25.1
> 
> 
