Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A30D512456
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiD0VLY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 17:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiD0VLT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 17:11:19 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E9D7644
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651093686; x=1682629686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=72myrHNOElx0NFEdtvKq9LM47tdwhmLkiKszPoSGAUg=;
  b=FsUicBLT6rFFGVwFI6mYHp0OAEMcplCrnkYxMl8d37mG477zEXDAH6eV
   tZuDJRtuhGebCG6CcpF2i+idrbS4u6JoqR2k5Ehj9ssv6jts4sjYyiR4i
   W4zD1iGIy3ANcvwPj+b8nb31KHgoPIjhL4zA4gdhnlh0QbH8nG4crIoQO
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 14:08:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 14:08:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 14:08:04 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 14:08:02 -0700
Date:   Wed, 27 Apr 2022 17:08:00 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        <kvmarm@lists.cs.columbia.edu>,
        "Salil Akerkar" <Salil.Akerkar@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>
Subject: Re: [PATCH v14 00/39] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <20220427210800.GB2047@qian>
References: <20220419112247.711548-1-broonie@kernel.org>
 <20220427170858.GA2009@qian>
 <Yml599vM948wXt6g@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yml599vM948wXt6g@sirena.org.uk>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 27, 2022 at 06:14:31PM +0100, Mark Brown wrote:
> On Wed, Apr 27, 2022 at 01:08:58PM -0400, Qian Cai wrote:
> > On Tue, Apr 19, 2022 at 12:22:08PM +0100, Mark Brown wrote:
> 
> > > but not SVE, SME is an ARMv9 feature and SVE is mandatory for ARMv9.
> > > The code attempts to handle any such systems that are encountered but
> > > this hasn't been tested extensively.
> > 
> > Running CPU offline/online on a Neoverse-N1 server will trigger a crash.
> 
> Can you try with 
> 
>    https://lore.kernel.org/r/20220427130828.162615-1-broonie@kernel.org
> 
> please?

Yes, it works fine so far.
