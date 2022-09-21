Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C525E5542
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIUVj0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 17:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiIUVj0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 17:39:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09474A61F1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 14:39:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso140776pjd.4
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=F49n0GDWtFmpiEIHBxknxSVaGxbsGKILhJWwZ2t+BIY=;
        b=mzGpGMY16PyeLUqED5yAMlsEOv41nLTQbC2DGal+lSNtg3tgwepvtu6yZsVNbpKNIX
         mK2p8FC6zZ5wE+oCfqn4hWEbLAB1G2VmzL8RBQh8NVddTm6Xa9mdndwTGs79/rRWw9Yt
         qMmVix4ap0MkiOB8Ia78WnvYF84wdztZITWX7I3SV3fVRcaHfuvlBxQBJc3ZmmxNTH7D
         lArHiD0DxV21v5rJI7k0Do8lFAHbX0J6/bGD75AujWRJ1Km72dX5ofW2Z5pSbBm7ZouW
         D88MQLGmgGOHOvQ/0m5nqdkrlAYC5EI7ekuM4lx1nVCqxpxKeRdW+qYOwy1KzS9Ok0Up
         OSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=F49n0GDWtFmpiEIHBxknxSVaGxbsGKILhJWwZ2t+BIY=;
        b=c0i2+l6DpOF5wH+qXF5zcrp4KBL5hOcJ4TvZAO056jsaSTX2JxnLk+47gegGIA+O0e
         dLdySEOTiGSOGl9SOSg6IFGd+RnJviSyIy8JDES8nyIJyU7+DXoxJaDesRJ49ks53Bur
         ozIYjpgk9aO5sMLZFla7+ZgVI9IemmbR2Qqy6IyRSM35oiMfA/jHdY1oKDlkyBB8Utf1
         ctxvbSQpJp51oNLVUI2TdDJWUotvsso18QkCu+h3CxXaq3ajQwM1Cz5sEsZ3s70YG6Rf
         8LKzATD2X+Hra+ox07/XOLEXTqJNmzucAPIJP0fVafGgVhI9r3CroXh7nUXvHuqLlWfa
         BOKg==
X-Gm-Message-State: ACrzQf04EAt33cCHrYkfDbXvMtFV4YVIw4Q+00hL1jMEALGVM0H7E0Dg
        6Bb9XiWZY8HeXaP9LPy4OYtDzA==
X-Google-Smtp-Source: AMsMyM76/uCVz6xKwCJLcbvJtMkqSyOKlQalG00ppHsbbHQGAc7sizW1/Mur+gYQepbX3lVr9p2kfQ==
X-Received: by 2002:a17:902:d70a:b0:178:5d52:9e41 with SMTP id w10-20020a170902d70a00b001785d529e41mr104932ply.0.1663796364312;
        Wed, 21 Sep 2022 14:39:24 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id bb11-20020a170902bc8b00b0016c57657977sm2511097plb.41.2022.09.21.14.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:39:23 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:39:19 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com
Subject: Re: [V2 PATCH 4/8] KVM: selftests: x86: Precompute the result for
 is_{intel,amd}_cpu()
Message-ID: <YyuEhxW4URWVvHyW@google.com>
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-5-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915000448.1674802-5-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 15, 2022 at 12:04:44AM +0000, Vishal Annapurve wrote:
> Cache the vendor CPU type in a global variable so that multiple calls
> to is_intel_cpu() do not need to re-execute CPUID.
> 
> Add cpu vendor check in kvm_hypercall() so that it executes correct
> vmcall/vmmcall instruction when running on Intel/AMD hosts. This avoids
> exit to KVM which anyway tries to patch the instruction according to
> the cpu type.

Out of curiousity, why do we want to avoid this exit?
