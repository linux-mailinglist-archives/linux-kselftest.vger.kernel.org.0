Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F357573804B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjFUKQD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 06:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjFUKP7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 06:15:59 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AA4D1710;
        Wed, 21 Jun 2023 03:15:43 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxXcfOzZJknxcAAA--.202S3;
        Wed, 21 Jun 2023 18:15:42 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c7KzZJkF3IAAA--.2918S3;
        Wed, 21 Jun 2023 18:15:39 +0800 (CST)
Subject: Re: [PATCH v5] selftests/clone3: Fix broken test under
 !CONFIG_TIME_NS
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1686301625-9477-1-git-send-email-yangtiezhu@loongson.cn>
Cc:     linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <69086c4e-501c-64a9-e7c2-4d8189ac7c05@loongson.cn>
Date:   Wed, 21 Jun 2023 18:15:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1686301625-9477-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cx_c7KzZJkF3IAAA--.2918S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1fXr43KFW7ZF47Kw1ktFc_yoW5Gw1kpF
        y8Zr4qkFZYgF17tasrZ34qgFy5G3WkJrW0krWUZ34UZr1Sgr93Xr4xKa48JFyUK3yF9rWF
        yFWfGF42g3WUJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4oGQDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 06/09/2023 05:07 PM, Tiezhu Yang wrote:
> When execute the following command to test clone3 on LoongArch:
>
>   # cd tools/testing/selftests/clone3 && make && ./clone3
>
> we can see the following error info:
>
>   # [5719] Trying clone3() with flags 0x80 (size 0)
>   # Invalid argument - Failed to create new process
>   # [5719] clone3() with flags says: -22 expected 0
>   not ok 18 [5719] Result (-22) is different than expected (0)
>
> This is because if CONFIG_TIME_NS is not set, but the flag
> CLONE_NEWTIME (0x80) is used to clone a time namespace, it
> will return -EINVAL in copy_time_ns().
>
> If kernel does not support CONFIG_TIME_NS, /proc/self/ns/time
> will be not exist, and then we should skip clone3() test with
> CLONE_NEWTIME.
>
> With this patch under !CONFIG_TIME_NS:
>
>   # cd tools/testing/selftests/clone3 && make && ./clone3
>   ...
>   # Time namespaces are not supported
>   ok 18 # SKIP Skipping clone3() with CLONE_NEWTIME
>   # Totals: pass:17 fail:0 xfail:0 xpass:0 skip:1 error:0
>
> Fixes: 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v5:
>   -- Rebase on the next branch of shuah/linux-kselftest.git
>      to avoid potential merge conflicts due to changes in the link:
>      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=f8424c54d041
>   -- Update the commit message and send it as a single patch
>
> Here is the v4 patch:
> https://lore.kernel.org/loongarch/1685968410-5412-2-git-send-email-yangtiezhu@loongson.cn/
>
>  tools/testing/selftests/clone3/clone3.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index e60cf4d..1c61e3c 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -196,7 +196,12 @@ int main(int argc, char *argv[])
>  			CLONE3_ARGS_NO_TEST);
>
>  	/* Do a clone3() in a new time namespace */
> -	test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
> +	if (access("/proc/self/ns/time", F_OK) == 0) {
> +		test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
> +	} else {
> +		ksft_print_msg("Time namespaces are not supported\n");
> +		ksft_test_result_skip("Skipping clone3() with CLONE_NEWTIME\n");
> +	}
>
>  	/* Do a clone3() with exit signal (SIGCHLD) in flags */
>  	test_clone3(SIGCHLD, 0, -EINVAL, CLONE3_ARGS_NO_TEST);
>

Ping. Any more comments?

Thanks,
Tiezhu

