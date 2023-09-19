Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF557A6238
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjISML3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 08:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjISML2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 08:11:28 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE0100
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 05:11:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-773a5bb6fb6so301434385a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695125481; x=1695730281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoyU9rzOy2BlH5KRJkQm4RzvdmE5afgsiRMrXPWn1pU=;
        b=gLpB6zQbJshv3krQTRKex0GrNT3IPA9krHe5nJXqUtt+YFJtVyUc1/cd2loBixvrwg
         UGj8l9NZ+uSieALoansEOT5DXd4E6pc+WFXRXgc+70U1LO1ubzl7azIhWY0hdiKChbCg
         ABGXqbX/aevuG9BY+OEgreUKLIjUKLlNjfeRDqI5/5lYkqNbInJLkTbOxOGWyeS6LZfI
         9p2FUyoVEWd5sLDc5pRgR/ySl1MIJ+gNF3h/7ykY/JO3F0iLEjWK+66Gc8pNhN+ixs3q
         eE8F/vrW5ZWNe3B2J1oMYGUfhIIY8wSWHoNipt1XbP+WP76ATw9zBaTBeWYgZAmgz4Ci
         0Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125481; x=1695730281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoyU9rzOy2BlH5KRJkQm4RzvdmE5afgsiRMrXPWn1pU=;
        b=CxKwOqIx5BGRwP+dk/aIqVwsW7z04507N4B5NZxZXMvS1PsuGOgrVxolq1UjazYtj0
         eiNjRV4llEWVh3yCp3U7VGCUDPJHRcBbTiCoxpTd4kWrGY2XC47N2fMLuMvkeJ6X8ufR
         kIKX63FZDlWBAjLtj/+/NQ/1ShksI9DLA1HnLPe00r1b5zBuVCfcBe7i9u/1IlxgrWHc
         XD6m3PX401pKv7b6ckGzkdoyUD/9w7SVSHFCLqU/0ZXTICPCa9A194vvasVPjHVwZfgB
         mb3jDU/m6Z42TFeFK7ka321H95Zai7EkicsLGORZpU/RHcIEJTu9XnFmr3c8FUJzXfhC
         4AqQ==
X-Gm-Message-State: AOJu0YxoDcuePy+eSFGAHHG+bVx2cPwj94YzAG670jWXGuYWySFHYcyh
        K8MBzS1vGSo3biKi2PUlT4TDAQ==
X-Google-Smtp-Source: AGHT+IHVTs08d8NaR/JqyVVIELGCXA1MekrWnfCHt/Y23q2QJTj4sfAfOGSXAGhdaB90Vcbx/q+Srw==
X-Received: by 2002:a05:620a:e07:b0:773:ad9b:4c81 with SMTP id y7-20020a05620a0e0700b00773ad9b4c81mr8836359qkm.23.1695125481742;
        Tue, 19 Sep 2023 05:11:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id g27-20020a05620a13db00b0076cdc3b5beasm3909448qkl.86.2023.09.19.05.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:11:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiZZW-000EC9-OI;
        Tue, 19 Sep 2023 09:11:18 -0300
Date:   Tue, 19 Sep 2023 09:11:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     GuokaiXu <xuguokai@ucas.com.cn>
Cc:     kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tools/testing/selftests/iommu:Fixed spelling errors
 in comments
Message-ID: <20230919121118.GS13795@ziepe.ca>
References: <31680D47D9533D91+20230904023236.GA12494@xgk8823>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31680D47D9533D91+20230904023236.GA12494@xgk8823>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 04, 2023 at 10:32:36AM +0800, GuokaiXu wrote:
> From c4e404036e0a7ffcaedc5760bee234713ccfe4a4 Mon Sep 17 00:00:00 2001
> From: GuokaiXu <xuguokai@ucas.com.cn>
> Date: Mon, 4 Sep 2023 10:18:04 +0800
> Subject: [PATCH 1/1] Fix the spelling errors in comments
> 
> Signed-off-by: GuokaiXu <xuguokai@ucas.com.cn>
> ---
>  tools/testing/selftests/iommu/iommufd.c          | 2 +-
>  tools/testing/selftests/iommu/iommufd_fail_nth.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
