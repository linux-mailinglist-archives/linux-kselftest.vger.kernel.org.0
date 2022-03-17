Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084934DC397
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 11:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiCQKHE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiCQKHD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 06:07:03 -0400
X-Greylist: delayed 371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 03:05:47 PDT
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B9C12CE;
        Thu, 17 Mar 2022 03:05:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DD634580245;
        Thu, 17 Mar 2022 05:59:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Mar 2022 05:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=0MGy6HvebexiCC2YhyoJoldMNm9d/DgjaE5btR
        Ao9JA=; b=EOLrAJUUzyotS3KHHDV+ihh1yuFc9PbARfH+aTTFPicj1CjJnnxoVl
        A94s0L2WRtoSveTeJf7cD+0BzjZOMOGa9Jy9F3BgLx/XMJsCvn3yB00ZDoKlDG84
        0N+wGEysgM54AfFc1gJR+jYt4Ek5UZfQ5qMLRneiUsgXOfVzt2eOtFKTrvp9e/ho
        XkKoQfycI5UOe82vIEbGaQFwJUsw1Tn3nsBw/uKVHS/t6fb8cmscMVQO24GOfMu1
        W6LYWO466c+xPcFWp1uSPOesLS0HaVTCzVd3U5eWRdyfd/3xv92zRPh+J+Xhhu8X
        UrVRrF/OB+ps+Daw3BNVo+cFG+mXzfYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0MGy6HvebexiCC2Yh
        yoJoldMNm9d/DgjaE5btRAo9JA=; b=IdmHbXsFPCgorP+QgDyJ+U4JRWjTFeBv0
        fcM/UxJuD1njO4W+uqXq7Ho8ccx9FdEwVMJXzhpg8lBKKy803iDeoaMTrvgOwVFs
        MyX/cjMtGKRLhndlrBJWcY/2GQztVOZD05l0ltf41xLg4mkUrt9unMFtAAY0w6T+
        cmeVT6RhX/kevcwduh9wQKQMzdw8ln9AnPpS7GbFmFw9duOD0p2BQN+OQOOB/DvO
        e/dqDvOr7ovJ61SD0ZGqfVYXrmb1rUIuIAFULFsSXPwFX0QE8BAa3HAXhJjG+xT3
        eZY2nJQ7Pt0ALAH0gWpuBENa1uYym+8Ls4ouMMDOJmv3mKJtiT/Qw==
X-ME-Sender: <xms:hAYzYtCwoCMGDOxC7QdIq37YR-Hm09c1MA5hEvckZqoiwHOmWhcauw>
    <xme:hAYzYrhE_DF9BNPvAHO1FwPjQ5ekHDBd6lhTb4J57yYwGaIyMupT99Cp45LEZtmjS
    10IumvYyipdkg>
X-ME-Received: <xmr:hAYzYonqJs8kFPretBhZv3kXOvR8BaR1dukXjcVq2M9i4qsXVvARWHO7yCps679SDAXDJn2OIrS_PsTUW2of-g5do0fHBs_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevhefgje
    eitdfffefhvdegleeigeejgeeiffekieffjeeflefhieegtefhudejueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:hAYzYnxeeHNmCg8ezmN-l5lIY8xPlVjSbmwi7NjZ56vQHp4BsGjPww>
    <xmx:hAYzYiRnty3dyHuvRkK_lCgje6qaEYUKZE401jUBLPjemCOhrEzhpA>
    <xmx:hAYzYqbe1wudRx339mg046LRHONIquLBrz7UKaDY5w89yZwPGhf_XA>
    <xmx:hAYzYtksPdP_VEtxd0PizzKDWR_tDCcTQRlz0UjtjUEOjycC9jLJuw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 05:59:31 -0400 (EDT)
Date:   Thu, 17 Mar 2022 10:59:29 +0100
From:   Greg KH <greg@kroah.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        david@redhat.com, frankja@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, nrb@linux.ibm.com, shuah@kernel.org
Subject: Re: [PATCH v3 1/4] drivers/s390/char: Add Ultravisor io device'
Message-ID: <YjMGgSstSCZAmcVa@kroah.com>
References: <20220304141141.32767-2-seiden@linux.ibm.com>
 <20220317094706.4921-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317094706.4921-1-seiden@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 17, 2022 at 09:47:06AM +0000, Steffen Eiden wrote:
> This patch adds a new miscdevice to expose some Ultravisor functions
> to userspace. Userspace can send IOCTLs to the uvdevice that will then
> emit a corresponding Ultravisor Call and hands the result over to
> userspace. The uvdevice is available if the Ultravisor Call facility is
> present.
> Userspace can call the Retrieve Attestation Measurement
> Ultravisor Call using IOCTLs on the uvdevice.
> 
> The uvdevice will do some sanity checks first.
> Then, copy the request data to kernel space, build the UVCB,
> perform the UV call, and copy the result back to userspace.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Do you have a pointer to the userspace code that interacts with this
kernel driver?  That would be good to have to verify that the api here
is sane.

thanks,

greg k-h
