Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7F70C2A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 May 2023 17:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbjEVPlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 May 2023 11:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjEVPlJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 May 2023 11:41:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67D2BB
        for <linux-kselftest@vger.kernel.org>; Mon, 22 May 2023 08:41:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso39168025e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 May 2023 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684770065; x=1687362065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZbI9Wjr8CPtJgehhTMTkDmsYOH6G4DAw3l/uTCKFew=;
        b=QiQLvgbc3foT90RwrkENIBertSwrQYuBmNYBl15SIUzvfTE0tufrgSD1OcGqBnNDu/
         87uF1cBXqZKWKkNJhPB2ePv03RTZ+ffD11XQygDZhhjAdBvhpN5MTjoPc5hy3l/Kk57I
         gcWOZ5Jvggm08WfsiKdsQy25SLn+rfzr1J5BUWAWxWJyjbcDMh5b2oCOiUeyAuk3gJhS
         gyd9Fly9eYWb4SI96+M/2yt3UWhK1jp8KvUjvsTx8UHamzkJYJh5OkIIVH5VE/laH4XM
         pRyM5+h7H6inZniVomaJXBICenUWfREcXG0ac9dyXWtsc5BleWqnq71ak+ZUMvRA2TMQ
         HbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770065; x=1687362065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZbI9Wjr8CPtJgehhTMTkDmsYOH6G4DAw3l/uTCKFew=;
        b=Ar4KK2/0fJIDpE2qgaDRRqSY7SQjeTVsjbi/XGmBiDoM6xxs9mbg4GlQJQ6sAN0Ryk
         vWkcjIrUe4kB81vfS5i4P8T4kDvSDMhecLRFbeLWPenb5c2Cr+bzFWjlfBk5FLh9NMrW
         P/cE6yEoU+RlgPNYNd8hU2NuX5/vvYQVccSccQaUxphn5Gy7kj9+irAItHmUW1tbgWpb
         uzeFzoxBou7VIG6tfdki/87wCAwrmkBD7WXRdlyTF32BmQZUURN+Sa5l59+HRanFdU6m
         uSblpNQjqfdVLD5nRyLjHpdOOyzi6DoQhGa9SExq77tkgOn6OtTUd7ExknHxwYU3Kf8f
         LB+w==
X-Gm-Message-State: AC+VfDwq0FNxzThWLii7I+4UqzNgaWc2TXly5ukV+HlS5itQ/wHV5u3Z
        uySLjpKuuU14aqlsId3Y8120kA==
X-Google-Smtp-Source: ACHHUZ5XGpgLCJW3YqYVYu+Q/4LUzOXgVsiGfL1ZFM0PSny4MCKkaY+MsVsawwM6maK61KKedEyuRg==
X-Received: by 2002:a7b:c8c6:0:b0:3ed:5d41:f95c with SMTP id f6-20020a7bc8c6000000b003ed5d41f95cmr8083901wml.11.1684770065249;
        Mon, 22 May 2023 08:41:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b00306281cfa59sm8159157wrn.47.2023.05.22.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:41:03 -0700 (PDT)
Date:   Mon, 22 May 2023 18:40:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in
 fpsimd_release_task
Message-ID: <43d53046-f8d9-4c4a-90ba-709910a13f97@kili.mountain>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <2d9a04d8-c09e-49aa-95eb-32b4679f7eba@kili.mountain>
 <ZGWE36pSRMsIHCCa@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGWE36pSRMsIHCCa@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 18, 2023 at 10:52:31AM +0900, Mark Brown wrote:
> > When we call sme_alloc() it will say the buffer is already allocated
> > and just zero out what we need for "vl", but the existing buffer is too
> > small.
> 
> If we are setting the SVE vector length we do not need to reallocate the
> SME state since the size of the data stored in the sme_state buffer is
> influenced only by the SME vector length, not the SVE vector length.  We
> unconditionally free the SVE state (causing it to be reallocated when
> needed) since the size needed for it depends on both vector lengths.

arch/arm64/kernel/fpsimd.c
   909          /*
   910           * Force reallocation of task SVE and SME state to the correct
   911           * size on next use:
   912           */
   913          sve_free(task);
                ^^^^^^^^^^^^^^
Sure, this forces a reallocation.  But what prevents it from happening
before we reach the task_set_vl() line?

   914          if (system_supports_sme() && type == ARM64_VEC_SME)
   915                  sme_free(task);
   916  
   917          task_set_vl(task, type, vl);
   918  
   919  out:
   920          update_tsk_thread_flag(task, vec_vl_inherit_flag(type),
   921                                 flags & PR_SVE_VL_INHERIT);
   922  
   923          return 0;

regards,
dan carpenter
