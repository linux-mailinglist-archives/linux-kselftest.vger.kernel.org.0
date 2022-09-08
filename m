Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6CD5B2822
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIHVJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 17:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIHVJt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 17:09:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB533E33
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Sep 2022 14:09:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e68so6130392pfe.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Sep 2022 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=z9Li9pBnsY2aSk5qTBSDkIw7EfiA5n4FZeT5aJ2NLZQ=;
        b=Yf5FKr34c9ANVml5Kp0eU6Or+5frA2zi0P/zwS/LxG8XtXWhUC3H2f8LKX2mVjV0sw
         sYwk+JeS9w1FF/Xu0+k6pDz8Von1XWRpnkNnY0yryJsrVzZVZ0kJiwM/g227q8NjpPXg
         RjEFSkdNLq726ducobxVkgKvi3zcsAkjhmNO5WoZzGxsk0f7YXYeKnwlm1OuZ7rsWLbw
         E1BoGb8nng0n1brdOIT26K7+YERd8LCP1qv/HX2HOlc0ob1/Cq8nAzmQmOgiK5x4jLqL
         AhhWDsUiYAf/C9U2qAuHMsbUj5wHtOO2c3CVouW+Xbp2gzL/d41EXRwVhDfJcrV0uAaO
         oLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=z9Li9pBnsY2aSk5qTBSDkIw7EfiA5n4FZeT5aJ2NLZQ=;
        b=rDPO++/EjJBvBxFeKliZdXiGRBetfi6PxeH0UW53s+FQjg9UOH2kI4Ym5Ak7XIJqkY
         PHcaLHSC6F+j/RL751alYA5iA4bAFsb85P1Ub1mcOh3uFA8sen1ItLHddyJhFJB2i4Ld
         sqvf218qntPAEPm8/3u7/+qDUV38taIidNQvaPhxxDMql3Hhg5UM+y2dFv0kbqXpHdmX
         fCkCKGS0CPwkjrsH4GXcBJqKX6qX3gjBKbTNXaChQRE7ppHfNMh8085tuw4H744Qu/EB
         UX3PRyEt2G/kYWZLnpIkWPODHibflFHwlPWGkqBfbolZu+Kl2KA+NJGGK4Dk1vfCHol9
         9bGg==
X-Gm-Message-State: ACgBeo02Dlhr/vtBkan2iiLGhKOyAuiUKSxWt+MVV/sWfNA0dBjp3EkG
        1O+iuJ1yDmqGoemYsbVJ8y49GA==
X-Google-Smtp-Source: AA6agR6M9oTF2yRJbQoMe6RbyFPb8y+rNRTuTZ5E0cB8MHjVuwrXp2Nm7C8kmdRsCrQHpE6EtOcqgg==
X-Received: by 2002:a63:f918:0:b0:438:766e:e57a with SMTP id h24-20020a63f918000000b00438766ee57amr1785235pgi.584.1662671386712;
        Thu, 08 Sep 2022 14:09:46 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b00172973d3cd9sm11365074plb.55.2022.09.08.14.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:09:45 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:09:41 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        drjones@redhat.com
Subject: Re: [V1 PATCH 1/5] selftests: kvm: move common startup logic to
 kvm_util.c
Message-ID: <YxpaFfw4jbwwvEI6@google.com>
References: <20220903012849.938069-1-vannapurve@google.com>
 <20220903012849.938069-2-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903012849.938069-2-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 03, 2022 at 01:28:45AM +0000, Vishal Annapurve wrote:
[...]
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -393,7 +393,7 @@ static void help(char *name)
>  	exit(0);
>  }
>  
> -int main(int argc, char *argv[])
> +void __main(int argc, char *argv[])
>  {
>  	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
>  	struct test_params p = {
> @@ -447,18 +447,15 @@ int main(int argc, char *argv[])
>  	}
>  
>  	for_each_guest_mode(run_test, &p);
> -
> -	return 0;
>  }
>  
>  #else /* __NR_userfaultfd */
>  
>  #warning "missing __NR_userfaultfd definition"
>  
> -int main(void)
> +void __main(int argc, char *argv[])
>  {
>  	print_skip("__NR_userfaultfd must be present for userfaultfd test");
> -	return KSFT_SKIP;

exit(KSFT_SKIP) to preserve the test behavior.
