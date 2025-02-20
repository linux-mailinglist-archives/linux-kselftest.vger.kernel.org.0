Return-Path: <linux-kselftest+bounces-27063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40749A3D873
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 12:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E88D17FDB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF5E1F2C58;
	Thu, 20 Feb 2025 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCakyOn2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506391B87EE;
	Thu, 20 Feb 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050308; cv=none; b=NOXcp8utjsymV/KyJRBGRrRCJf4QztNe5tYl0iTSPCxs6OIcZjxQI8mpeel/YDmrufC3ow1Vvlng5EEQk7gTryyB5HlDoA+kFRBv+NkpxHQklRMYfVx/t6ON834PZrbFLgDUQ1KD3VsKYpxs6LoNdJIiXP4K/ZtdPXZRlGDERaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050308; c=relaxed/simple;
	bh=v+2JXh1RaYXQtGVAq0rtJIKhqX2bs3Vs4fG02pBGPSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lntErhOXtthpG0P1lqPaiP4cF16vVPBqmw8XFycolHVjv1fu0tPgtH3oIMlf61hccpwwvhXgH5HecGM49DlbkRpo/ILj5/tOWllHtEQ49GNTbWJ5BPNg5bAHVHGrWP80ckzFHEqMwGQe5xmWomNYa4sFpi7RNqlhpYqw+FbRrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCakyOn2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c2a87378so11468045ad.1;
        Thu, 20 Feb 2025 03:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740050306; x=1740655106; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=97BJ8k7eBLzkl/lAExyOJI4q3ByOLr1bJKrLPeqlpBg=;
        b=bCakyOn2uWiMWHFqCp9w7kQyZAH/cOHoroT2wQnDJht+RWdmkYDq5qAKUYF/vxh+yO
         Nq6DKOWX0s4ZAhnb7OLy3DOf74mcguEBG+XyLSOxUOJ5gdJCLzcOyiyje9DoQ+Z3JtT6
         yPgVRdbzICvcrTdSJ3D8BWdYwveBQoPBOJlFviFGpKCDANpCfAnaW3c2wsHCZtK1ItKo
         Y2MKfXRp82AnsXTy+vATYItUMJ48h8nsV35Mqe88PX+SSi6CtolBIDzRv7+zfEWybvki
         TxfltvwDNiose/HyLINCMZCKI4cT2xUjmBj2yj2tD9lDdphDUj/kWCN27s1nyo10e18O
         r14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050306; x=1740655106;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97BJ8k7eBLzkl/lAExyOJI4q3ByOLr1bJKrLPeqlpBg=;
        b=e5KCldpMK+H3sAmm6ret7ZEBQIngWziSyZBczzmiHCp5tgGwQkIdGQP0YCTSihuio7
         1GNffvT07MRWQiXpn0xS+KNQS9hSPprDDIFbrKrzMTu8sOo2lHpoY5KX8UyNVFb3AcvP
         w7s1IorE8fYpN8S/0g0RT/4kaccgzax0LEarGJfyF635sbGOXUpKpbc1vpaRG4bTtipk
         ZOm3g2RFxLZkyvfMRRB5Q0wsJ11/yVm92X1z4SWBmxbjKBndg7wAvDB52qzJLDvLVGXD
         rXm9oG9+Yufex0Q3q/Ci+Z3GrdzFcVX9bXKS12g/NBUvYDTW0Il2LY3QhZiiKfRezUPx
         X2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXC+pCTqEGHgWgB4ug2KyffLoE/ReeEoVHjWmLiZ3oksVKkKsAFZHriP2i0w0ZlLdVi66nx0+q@vger.kernel.org, AJvYcCWlrQiZ5kmT3vDbA0ZXYc5srpeeElfMBijvyO785YpUMEWUpTrP3FNgWJof8esCIQvqrosjXxU8XZDMa6Q=@vger.kernel.org, AJvYcCXTABBzsMM0hXWKNB27z+LJIjmkOAllW2wx2oWs+aWowhL5ub5u/6hULLR4fcdjzpjK2hiNLs91saTfKx+UoMoF@vger.kernel.org
X-Gm-Message-State: AOJu0YztiMJob48/zvmX8x7OcmpJpvOqQw3oHpmSX2xrStynrIqtUgJ7
	ul9vQ+Uw8SCxOC+kOSO22rgBS2/E08VffHphq/ZFo+YQbfKQmdnw5ZgB6fD/RbUE4w==
X-Gm-Gg: ASbGncuxONLDrqmJES+y+dW4jzp2sSaK9o+BXGRm5r13ySFuB73471WtMZ3Y3NfcR5n
	/WGK1cvbLZRL/NiI3P7aG2DfAesPLrCZ3K2li1wg6md6JUii5swWr5B/kDHDLFPXzoqL6IWHxE0
	gMYkCC6fANQHWqq5jBM1oEPk+6R7YQXlsVh20sg4Ggs//7cb/9ZyO5CcVReg6F+adsq/IYHjF+p
	0gVlbkva+GQCDMd6jIOYLgY1g3sZQ9lWIUp5DKxQ2Cky+V3djh6skcX84IJZH6Zg5EEE9KYzI+6
	/kgMJlhwbcWoKPFDgHo0
X-Google-Smtp-Source: AGHT+IFcGVwDIU0Fe59ENG3ZtFCwL0ZNfjrNS0zMoqh6QzV7UaceDRVxzMIZnzW4HfiRZE+nf9mhkQ==
X-Received: by 2002:a05:6a20:734f:b0:1ee:d6da:b646 with SMTP id adf61e73a8af0-1eed6dab88cmr11720958637.11.1740050306451;
        Thu, 20 Feb 2025 03:18:26 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adc746d1079sm10874784a12.68.2025.02.20.03.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:18:25 -0800 (PST)
Date: Thu, 20 Feb 2025 11:18:15 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"andy@greyhouse.net" <andy@greyhouse.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	Jianbo Liu <jianbol@nvidia.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z7cPdyDZ9OOIgU7c@fedora>
References: <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
 <Z3u0q5HSOshLn2V0@fedora>
 <Z33nEKg4PxwReUu_@fedora>
 <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
 <Z34l6hpbzPP9n65Y@fedora>
 <Z4d9pVshf3RKQp_o@fedora>
 <Z4oM0cWuipPCWqeo@gauss3.secunet.de>
 <021da64bc786df118dff1a9724c6958a517a56cd.camel@nvidia.com>
 <Z47jVoQdO9sD19TB@fedora>
 <40e2170b52f1f80fd72405df6901c4323f903e67.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40e2170b52f1f80fd72405df6901c4323f903e67.camel@nvidia.com>

On Thu, Feb 20, 2025 at 10:48:43AM +0000, Cosmin Ratiu wrote:
> On Mon, 2025-01-20 at 23:59 +0000, Hangbin Liu wrote:
> > > 
> > > I am not sure this can be fixed in bonding given that the
> > > xdo_dev_state_delete op could, in the general case, sleep while
> > > talking
> > > to the hardware. I don't think it's reasonable to expect devices to
> > > offload xfrm while the kernel holds a spinlock.
> > > Bonding just exposed this assumption mismatch because of the mutex
> > > that
> > > was added to replace a spinlock which exhibited the same problem we
> > > are
> > > talking about here.
> > > 
> > > Do the dev offload operations need to be synchronous? Couldn't
> > > __xfrm_state_delete instead schedule a wq to do the dev offload? I
> > > saw
> > > there's already an xfrm_state_gc_task that's invoked to call
> > > xfrm_dev_state_free, perhaps that could be used to do the delete as
> > > well?
> > 
> > Yes, I have tried to move the bonding gc work in bond_ipsec_del_sa()
> > to a wq
> > in https://lore.kernel.org/netdev/Z33nEKg4PxwReUu_@fedora/. i.e. move
> > the
> > following part out of spin lock via wq.
> > 
> >         mutex_lock(&bond->ipsec_lock);
> >         list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> >                 if (ipsec->xs == xs) {
> >                         list_del(&ipsec->list);
> >                         kfree(ipsec);
> >                         break;
> >                 }
> >         }
> >         mutex_unlock(&bond->ipsec_lock);
> > 
> > But we can see there is an (ipsec->xs == xs). So we still need to
> > make
> > sure the xs is not released. Can we add a xs reference in
> > bond_ipsec_del_sa()
> > to achieve this?
> 
> Hello,
> 
> After staring at the issue a while longer, I am also converging on just
> moving that mutex part from bond_ipsec_del_sa out to a wq. I browsed
> through all driver implementations of .xdo_dev_state_delete() and found
> none that sleeps or allocates memory with GFP_KERNEL. So if we only fix
> bond_ipsec_del_sa, that would be enough to make it all work again.
> 
> So it should be perfectly safe to add a ref to xs in bond_ipsec_del_sa
> before firing up a wq to do the mutex lock + list traversal, before
> releasing the ref.
> xfrm_state is already unlinked from everything by __xfrm_state_delete
> before xfrm_dev_state_delete is called and the xfrm_state_alloc
> reference is dropped by the end of xfrm_dev_state_delete, so the only
> thing keeping it alive would be the reference added in
> bond_ipsec_del_sa. When that is put after the list traversal,
> __xfrm_state_destroy gets called with sync == false, which passes on
> the baton to another wq to do the gc for xs.
> 
> This all sounds reasonable.
> Will you chase this down or do you prefer me to send the proposed fix?

Thanks for the feedback and confirmation. Let me try it first. Hope
unregistering bond doesn't affect the gc works.

Thanks
Hangbin

