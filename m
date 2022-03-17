Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E88A4DC54C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 12:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiCQMAp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 08:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiCQMAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 08:00:44 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C55173374;
        Thu, 17 Mar 2022 04:59:10 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DA0B9580275;
        Thu, 17 Mar 2022 07:59:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Mar 2022 07:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=NfFJnkbS3KtilmlXQThAwkw4X4l3eg9znnE/jO
        g1d5E=; b=N7X5g0pEnkMstgHhqa5+3+0BxTuLz3jVhklrKWMqTOsjegxrvnn1QH
        Fkdqg24A/ZPO41OAHum1syefQta0Tpi3oVmP5kV8Py12EHR0up9gRD2xvTI7uoa9
        7D/+0PzOTRErTWQd+XprZVizUqWWf3YjC82AHS8ni1cN4R/C73z1BBPE2rw523xq
        CkhzuIOPZwqLTjDVqY+Tl5L4gurrdZTgGPc5tTx67ncRL66cXwhB27hSqx4gNDAO
        RZ7HOop1Tei6M11w1rk7aFAfewV/qSDpIngB2tqbdV695Du2NuMCHf483Fc56lRu
        XpAZErArtRSnJmaNcUU9QC+MM2mW82AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NfFJnkbS3KtilmlXQ
        ThAwkw4X4l3eg9znnE/jOg1d5E=; b=hD1Gz/uapIf/sWB9JNGq2bqENk7Jvi4hN
        Y0UvF1yhANVZFON0lDUCzuGbeJQLMNYy8rMbUNaasWYetsyeI8RvU3uVYj4G/XzV
        hUd5Xt4VKRDcFc61ktuXCtuBjJjZRG7JBly0e/6dGp3yI1SGxLcaOZjwaHxIlDA4
        MCQZ17wR7waqIx3n6yPT7Nkq4wHiSw7ryxi53joG27ELAZYgNQNHr9WTnxaBm8dx
        G1hOwLABojoLiGHCZDlz8jcI4sY7YOOflgS19LdWg/S5JeIDA48MBIyHi0W/fcC4
        HbFAqAW2y+HIOkoX0myj6dIWm3OjHtc5/MmzRn8d7UKlPO/eVgCZg==
X-ME-Sender: <xms:jSIzYsskDvWb7X-Jb8vYizwxdLJTYB-dmk1uznYkPEODEfYfQnkZYw>
    <xme:jSIzYpcoLkl4N6S17qTcUmXINKE6tpxzQO6jjGbGBwXHIJC_7FMfbliFXCinLRNuI
    UT7xcVmTZTeLw>
X-ME-Received: <xmr:jSIzYnxKs_WExetxBzF948L5tleHabZroB3pjVjlPYRhp66oUEX2ah-YdrjkHhFEwGlSko8hf4yjos0nKpkl559k--gF8oCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:jSIzYvOKdSmNOe5q9nzBP4i0bVe4Vifx9yNFfzDzTyDsTENkwnuHNw>
    <xmx:jSIzYs8_KlCfxHsGGGD8EZd0FyGIPhWGPa85ixPflkJawBatUCzIrw>
    <xmx:jSIzYnXBC-3TXQI5QCnD61cP629Zi7Co6Gh6K05b4WbMvEziWXPURw>
    <xmx:jSIzYgS3WKweICGsPYsF1o0_VVIE8DYgbqLe2Dx-KvuzLG6AZPYmCA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 07:59:09 -0400 (EDT)
Date:   Thu, 17 Mar 2022 12:59:06 +0100
From:   Greg KH <greg@kroah.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        david@redhat.com, frankja@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, nrb@linux.ibm.com, shuah@kernel.org
Subject: Re: [PATCH v3 1/4] drivers/s390/char: Add Ultravisor io device
Message-ID: <YjMiiom+zRfkhe6F@kroah.com>
References: <20220304141141.32767-2-seiden@linux.ibm.com>
 <20220317094706.4921-1-seiden@linux.ibm.com>
 <YjMGgSstSCZAmcVa@kroah.com>
 <6175e7fa-070e-8ab2-843a-8019d0dc0c83@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6175e7fa-070e-8ab2-843a-8019d0dc0c83@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 17, 2022 at 12:07:58PM +0100, Steffen Eiden wrote:
> Hi greg,
> 
> On 3/17/22 10:59, Greg KH wrote:
> > On Thu, Mar 17, 2022 at 09:47:06AM +0000, Steffen Eiden wrote:
> > > This patch adds a new miscdevice to expose some Ultravisor functions
> > > to userspace. Userspace can send IOCTLs to the uvdevice that will then
> > > emit a corresponding Ultravisor Call and hands the result over to
> > > userspace. The uvdevice is available if the Ultravisor Call facility is
> > > present.
> > > Userspace can call the Retrieve Attestation Measurement
> > > Ultravisor Call using IOCTLs on the uvdevice.
> > > 
> > > The uvdevice will do some sanity checks first.
> > > Then, copy the request data to kernel space, build the UVCB,
> > > perform the UV call, and copy the result back to userspace.
> > > 
> > > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > > Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> > 
> > Do you have a pointer to the userspace code that interacts with this
> > kernel driver?  That would be good to have to verify that the api here
> > is sane.
> > 
> There is a userspace tool currently under development, however, not yet
> ready to be published.

Then really, this driver should not be merged until the user/kernel api
is determined to work properly, right?  Why submit this now if userspace
isn't working?

thanks,

greg k-h
