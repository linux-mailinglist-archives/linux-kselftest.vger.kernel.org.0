Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C84F8055
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 15:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiDGNT4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 09:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343604AbiDGNTn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 09:19:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274125C5B5
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 06:17:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso6199614pjh.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xaFEdMdha8h42RWuuCwkqr0VCzd2sB+RNX9htkQaFF8=;
        b=Q4WySDtp3npUzYr7LCaMAKpcChHDjH5EtYUxBS5WjOSTpOpufANpns13Wj+Gr5G4fd
         4PLyrEBAHnA8hP7wi5Fp4DWo3gcHnsvGkCyd9de+rZCEyRvhfh+9OyU43/6ViKKekO3t
         ACFLGS30cXfOQMNSCfPt8RKp3Z/31TLN7JJLVJHkGsuC8p+owLhPH1Jmuaowilivo7tK
         VJjHd2wg0+tNykHOV//TkfGAyTOj1fc/5aM8aqbyUgrgZDMQteysSqAFbFCCMB2llKt+
         RIGkunul47ZCrDyTAnmjYJweTgzfRcLRQ0qiyCL6wyUIX0BAF95+9a+hsJhych8H1lSg
         ScGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xaFEdMdha8h42RWuuCwkqr0VCzd2sB+RNX9htkQaFF8=;
        b=SydTQmw/L3jO8tR96TKfT0Hs/5ga6ZNLUl7ILD91x/B0fGJoP7bYOFVTSM7+SYn459
         C+a7i0rt5fFTiE9J29NmSytaJjVRxh849OjGyoKmcWbCX3W2P3tEzvZjB7Rwt2UgXqYu
         D9fDsiFIFhb6/Dw7ZWJhAvb7z0p95k/OAhaZtbE9SGso+vk2cEAntRnmpmTZ8dpRaDz8
         WRFheN96imSDAeUxX4t8lF6+zYTCYYnxXXAWhis/vBhp/oWKRiy3UmfwepTLCvB4xLsR
         Lln3OuBGXRjdLNK+SRsOtXbLt4vVvoLbRG/h45VpjCXtKd5TWnzcsTKINo9m4nC6FYUI
         9Pbg==
X-Gm-Message-State: AOAM530yxHJKAZd1vVg3zAKJjnKL58MwdJkfStWpaR4IB5FAna/BWmLP
        sCEMX6voygPbqDfzJHbtR90W0w==
X-Google-Smtp-Source: ABdhPJzAIA6zaue5y4/HWCW1DduN5qnV98L+dQLWSOQjhzJalpap83t1+9GZcLK+U+u0+q/rNrvpXQ==
X-Received: by 2002:a17:90b:4c12:b0:1c6:f450:729d with SMTP id na18-20020a17090b4c1200b001c6f450729dmr16146151pjb.190.1649337462055;
        Thu, 07 Apr 2022 06:17:42 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0024c500b004fae56b2921sm22997159pfv.167.2022.04.07.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 06:17:41 -0700 (PDT)
Date:   Thu, 7 Apr 2022 21:17:38 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
Subject: Re: [PATCH] userfaultfd/selftests: use swap() instead of open coding
 it
Message-ID: <Yk7kJsk6Y+ASF7ZA@FVFYT0MHHV2J.usts.net>
References: <20220407123141.4998-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407123141.4998-1-guozhengkui@vivo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 07, 2022 at 08:31:41PM +0800, Guo Zhengkui wrote:
> Address the following coccicheck warning:
> 
> tools/testing/selftests/vm/userfaultfd.c:1536:21-22: WARNING opportunity
> for swap().
> tools/testing/selftests/vm/userfaultfd.c:1540:33-34: WARNING opportunity
> for swap().
> 
> by using swap() for the swapping of variable values and drop
> `tmp_area` that is not needed any more.
> 
> `swap()` macro in userfaultfd.c is introduced in commit 681696862bc18
> ("selftests: vm: remove dependecy from internal kernel macros")
> 
> It has been tested with gcc (Debian 8.3.0-6) 8.3.0.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
