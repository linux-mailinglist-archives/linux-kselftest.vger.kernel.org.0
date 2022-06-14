Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773CF54B641
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbiFNQbu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbiFNQbs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 12:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3494D443EC
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655224300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oavP8gsV6cJWMEx/ty3RSD/S2p03O0ZnolvRU2i8U0U=;
        b=AXaSp1R5dTOazmBr/xwLsKeIcCQEs8omJNxnUKnr5gFRtHZFo9ymOUIiLNTWDUSmzOXP1e
        82JqXBY+dYVZ1Zn/YHuF32yjoaD4mpYLDL0yijDLvHhVOCBJjIKCj1/8+sjtnZjIAa7BMa
        TzgtVf9U3h/Uy6M5f6ssgdz1i5FqWMU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-CgU3ycf5PSCI5QezvAu6AA-1; Tue, 14 Jun 2022 12:31:38 -0400
X-MC-Unique: CgU3ycf5PSCI5QezvAu6AA-1
Received: by mail-wm1-f72.google.com with SMTP id o23-20020a05600c511700b0039743cd8093so5025145wms.6
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 09:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oavP8gsV6cJWMEx/ty3RSD/S2p03O0ZnolvRU2i8U0U=;
        b=nOqCip8+BR4l6hPnalKRgLze4QacyQZs5HVCObV0bNokHP50Y1hsb80dkX9Kf9hJhu
         ejNK+GgaHFA0OGgw6AXQEUiYdSnXgOg3v0PPcNRm3iliXry+i4qDsy5lyC89plsTbJ9I
         x/2jCWyE7rxTmGgGf0/lXAFaf7+JaoaquGD2NJrYmcwDwRtMUoFaTnwtDLwVQAw3Vham
         wErOIKdyYSf0NmUD1/hz8G3Ow1Dqod0XxUZDNYNStablH65PXHTxxGFHaHtne2MQWc6x
         arlc64xDRFKLaDesCqa8VULfVH5ZknFsmlybi63glZytM9Pla91f9ywSr4QMWKJkyJan
         NSMQ==
X-Gm-Message-State: AJIora/WfJLoHWHr3x9W3HysjU4E3a1ZspZxfMWt5m9BGHhOTiWETvz8
        T7Om8UE9jtelsIg7iICu2mtsuO/zPsdsydobfdqlEaxSIsYKTea5gSco4raAg1bDITqMxNdnrry
        z53omuDZ2WaGwXczf52ENckvQ59K1
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id u3-20020a5d6da3000000b00219bcdd97cdmr5702987wrs.274.1655224297805;
        Tue, 14 Jun 2022 09:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1svQzIL6zLCvemWeG8M2S6FR8uXiEVS4pzOzqfRybaUZfeRrJrTeJlYzJRR2cIqLDUDDp3ugw==
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id u3-20020a5d6da3000000b00219bcdd97cdmr5702966wrs.274.1655224297599;
        Tue, 14 Jun 2022 09:31:37 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-42-114-75.web.vodafone.de. [109.42.114.75])
        by smtp.gmail.com with ESMTPSA id m17-20020adfc591000000b0020fff0ea0a3sm12632199wrg.116.2022.06.14.09.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:31:37 -0700 (PDT)
Message-ID: <047aa23e-7926-6f8f-eadd-122dc81a3159@redhat.com>
Date:   Tue, 14 Jun 2022 18:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] KVM: s390: selftests: Fix memop extension capability
 check
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, pbonzini@redhat.com
Cc:     david@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, shuah@kernel.org
References: <36d83871-343d-e8a0-1aed-05bf386f9b1b@redhat.com>
 <20220614162635.3445019-1-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220614162635.3445019-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/06/2022 18.26, Janis Schoetterl-Glausch wrote:
> Fix the inverted logic of the memop extension capability check.
> 
> Fixes: 97da92c0ff92 ("KVM: s390: selftests: Use TAP interface in the memop test")
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> 
> Here you go.
> Hope it doesn't get lost as a reply, but I can always resend
> and it's not super critical after all.
> 
> 
>   tools/testing/selftests/kvm/s390x/memop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index e704c6fa5758..e1056f20dfa1 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -769,7 +769,7 @@ int main(int argc, char *argv[])
>   	ksft_set_plan(ARRAY_SIZE(testlist));
>   
>   	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
> -		if (testlist[idx].extension >= extension_cap) {
> +		if (extension_cap >= testlist[idx].extension) {
>   			testlist[idx].test();
>   			ksft_test_result_pass("%s\n", testlist[idx].name);
>   		} else {

Thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>

Paolo, could you please queue this directly as a fix for the "Use TAP 
interface in the memop test" patch that is currently already in your "next" 
branch? (or in case you rebase that branch, squash it directly into that patch?)

  Thanks,
   Thomas

