Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995DE56D3B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 06:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGKEWo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 00:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGKEWn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 00:22:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50FF18B1F;
        Sun, 10 Jul 2022 21:22:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so7154199pjr.4;
        Sun, 10 Jul 2022 21:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dy7+GGN73umpQ2Bj6ZKtVNghFJ8bz6lPPPijWYG4Dy0=;
        b=iqarByK8IT+N2BbRHDK6Rtx6x6WVei2xs98PxQ+dt/A8dXl91s0EamQ5q1Jjg9TsL/
         yy+c7ADACWYCbh/WmABlv1vyE4towXZ4h9Cz13GEvu/mp16IJU8Niqqpo9DvUKLbkwVc
         u6ELg7Ft3k3kB0lebbvYLwwfc2tHfjQufadRsLLa9IywNg+t7rnkgiLbLBArlR9kJc0K
         hbC+T85cz6REwN1lA+czh0IdHWHgNXVN6nLNmpLl5ErXC8QA7h5QzSpIRwfyvlJtt6uN
         5f3ygL4FrIkUHXyPq7ODAS/efk0ehpwO04th8I0nOyBwY/bOJn1OZFL54PN8o4laDoqU
         hajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dy7+GGN73umpQ2Bj6ZKtVNghFJ8bz6lPPPijWYG4Dy0=;
        b=i49Ghk9kzCv29PMjwkfXAcSYnlVy0HRz3QYDnkUuCHJpR/sG1R88/q9hxzCSn0nh2i
         /bpXL2v8JdsKc+JfJmQ05Krv6mqeVGMwJ7oDaUDGW3o+wggCZktS7hPQ5JGMQBwLCxwx
         aMqko9LHmwbJY//Db2wZ9ZoF+WHeqBHBDzjXugt5RowBzaIf+0bA7lC4ZuokzFC7eJQj
         ssqqUMgJXM/ELb23RYaB1Rc86di8Ad2A3pfhFa78epIjImP88oMrS6A/QVKdlblV6sjl
         u7TQMKAnGKmSC7kKRsopoECQs9BsT9YWbBPv75nHhOlzOOMOOzAReVfawtfMRFUWewgd
         wPCQ==
X-Gm-Message-State: AJIora+bq8zBTk9K/IHzTreBhUPFeWSvkq5ByR2WhDoEY1w6uPj9BqAk
        qELGlBMbf5tUKd+sXtrQ5ww=
X-Google-Smtp-Source: AGRyM1uiZMUMMhRPI8kqqb30ejrMbEQUWkDHOx9Vj+HTvTOSd+7yf1HmDg+K9oQ/6MfPZ9xHR/Yhqg==
X-Received: by 2002:a17:902:7290:b0:16b:b6b5:7e6c with SMTP id d16-20020a170902729000b0016bb6b57e6cmr17081706pll.116.1657513362248;
        Sun, 10 Jul 2022 21:22:42 -0700 (PDT)
Received: from fedora ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a154800b001eee8998f2esm5877357pja.17.2022.07.10.21.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:22:41 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:52:36 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/kcmp: Make the test output consistent and clear
Message-ID: <YsuljDee9KGDPfsH@fedora>
References: <20220629192822.47577-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629192822.47577-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,
Please review this patch and let me know if any changes are required.
On Thu, Jun 30, 2022 at 12:58:22AM +0530, Gautam Menghani wrote:
> Make the output format of this test consistent. Currently the output is
> as follows:
> 
> +TAP version 13
> +1..1
> +# selftests: kcmp: kcmp_test
> +# pid1:  45814 pid2:  45815 FD:  1 FILES:  1 VM:  2 FS:  1 SIGHAND:  2 
> +  IO:  0 SYSVSEM:  0 INV: -1
> +# PASS: 0 returned as expected
> +# PASS: 0 returned as expected
> +# PASS: 0 returned as expected
> +# # Planned tests != run tests (0 != 3)
> +# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> +# # Planned tests != run tests (0 != 3)
> +# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> +# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> +ok 1 selftests: kcmp: kcmp_test
> 
> With this patch applied the output is as follows:
> 
> +TAP version 13
> +1..1
> +# selftests: kcmp: kcmp_test
> +# TAP version 13
> +# 1..3
> +# pid1:  46330 pid2:  46331 FD:  1 FILES:  2 VM:  2 FS:  2 SIGHAND:  1 
> +  IO:  0 SYSVSEM:  0 INV: -1
> +# PASS: 0 returned as expected
> +# PASS: 0 returned as expected
> +# PASS: 0 returned as expected
> +# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> +ok 1 selftests: kcmp: kcmp_test
> 
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  tools/testing/selftests/kcmp/kcmp_test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
> index 6ea7b9f37a41..25110c7c0b3e 100644
> --- a/tools/testing/selftests/kcmp/kcmp_test.c
> +++ b/tools/testing/selftests/kcmp/kcmp_test.c
> @@ -88,6 +88,9 @@ int main(int argc, char **argv)
>  		int pid2 = getpid();
>  		int ret;
>  
> +		ksft_print_header();
> +		ksft_set_plan(3);
> +
>  		fd2 = open(kpath, O_RDWR, 0644);
>  		if (fd2 < 0) {
>  			perror("Can't open file");
> @@ -152,7 +155,6 @@ int main(int argc, char **argv)
>  			ksft_inc_pass_cnt();
>  		}
>  
> -		ksft_print_cnts();
>  
>  		if (ret)
>  			ksft_exit_fail();
> @@ -162,5 +164,5 @@ int main(int argc, char **argv)
>  
>  	waitpid(pid2, &status, P_ALL);
>  
> -	return ksft_exit_pass();
> +	return 0;
>  }
> -- 
> 2.36.1
> 
