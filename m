Return-Path: <linux-kselftest+bounces-48953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B0D1FFB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 16:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04EBB30082D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A143A0EAC;
	Wed, 14 Jan 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrXFRNpY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfUYU3I6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5D3A0B09
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406074; cv=none; b=O5TZBR1a98FFdM7MKXX+rSa2rxKlKEPHmpO8KIfABrTRmRi7oOFHRjE41HVTCjglLdjjgtONvUtpqRLJCEoy9qnsIzp+Gh/CHZScuUD/6d5jjXKLS8tc2OaFkR00i9F54VZXePqgAImD2TAJuz4eGFTvp00FuJUwJCtAULOkc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406074; c=relaxed/simple;
	bh=vu8wNkY+ONyZ11dQOa1RhYbfZ6CIfKh+CDlvLi9Pphk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8USEQVbqD70+BSHbBnXi4duqxsiRplwf1hZyv8vjkPO81jqEo1tB6P3UJQ9Xf/0stGnu3OQKiWpsKEPgyLpbyhIyxpZznQNxQdvgaNjsQ+7b4O1CT73Am/cXrBCMK42IWGq+LyzbZFEmGI5+Vvz5DP6mbzMSTjOMCwUMvGgKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrXFRNpY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfUYU3I6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768406071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45w2Nqp7W5ReZCd4Up6qyFBRnRWCXaqu4990woCkPZ0=;
	b=MrXFRNpYH8wUVQnmIR9XvMEq7byxOJlTwsZK9GiQ0thZ9Ob/iBxJ4ZuSDmekt4/Hn+VP+A
	9MKY0TwRcytqfMXhQslgez1p6JTTZ081M9SzeJuOamrqXeuGOQtr0AXriIYALqcgTR4DfA
	JzS8pP5CFj0VsTclfA1AxZE9fd5ffJA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-aaKhZGQxOGiEtqu1HzpAgg-1; Wed, 14 Jan 2026 10:54:30 -0500
X-MC-Unique: aaKhZGQxOGiEtqu1HzpAgg-1
X-Mimecast-MFC-AGG-ID: aaKhZGQxOGiEtqu1HzpAgg_1768406068
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso16372007a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 07:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768406068; x=1769010868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45w2Nqp7W5ReZCd4Up6qyFBRnRWCXaqu4990woCkPZ0=;
        b=HfUYU3I67nA80vs1ntunHYhEWVdZpA75QutEdzJDO9yTjYaEF1+7mFCQDghFSlT4cC
         WYrjBmLkCWxH/ice8Q+FsXKECBpBjIbLhuV09EyYLkveJnpuiEiKvw4aYp2xB8V/lit6
         GBakRdXp+8+c78uXoT4w3LRwD9Wdc7qfLHfhx4JJ+4EHGOPKDRqnhA1esGNK17KrwdHN
         VUi7TYB6zLWaU+Jpaja3P6e/260gfdSHJSJ+U1mizjLtw+B4b8UKLzAdjmEFCM3iKl3P
         MxWZhBCQjqFEg8WV5Ek+2wjH2w6lEXB5uQVKtFDL+DowQma0So4LWt4RLcEccmlNs5SO
         RSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406068; x=1769010868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45w2Nqp7W5ReZCd4Up6qyFBRnRWCXaqu4990woCkPZ0=;
        b=QyNMBKrGmVYaA0vYZx2WbbyJymbZInPindLM2S9uw1YM4c2b6e/MxUq/t8KfccCtly
         iEMWvYuA/5Yb+kpAfOoJAnvrOkd7h+4Q1qAf3viwl7CzR/c/5mlMgC0HOmPHee+eLSVZ
         c6hbX1mvsNrCJhmibervySvwrwUG1tjKmD72YEYWq9PKEbGR3mdMCEi2pgNeo5QZBMio
         2E2g2YUARM5Q/enniyL+y2Y3OguEoCpu7i+Xlof0pZKNgutcuT2jR3sXflw+qLd9u+gw
         8PLzXe1xn82Z6q2bLQKwP7t608uQCawWarTyuGPiOi7Yh/sr9clje2OdQnL+btCqtQPl
         yxIA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ou9rijYoqoSMIU/jQga1Em155BhkgvuTfJd4QvI17dNLsJSxPWq56646u0PCeDzx92fwlugaRcTt4m/5VJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7yvcgw8ZFnJcS8wIm2GhhV+/fZ72mIRxruNCM+lwC2kFvaM9s
	DasbenmvEmyBQSJmqdJSe6RpzHQLGplnfVwRDmTYCspX2Yo5CZw60zW8EIHFqUv89+yPIVYsErc
	VW19+BmoD2YxRB2reRJC7F2EM42YGVfQJpAJW0Z688sULpnPxORpNgbB7bL0ivZizIfP0IG80OQ
	QlpUUa3ywp0w+FxnomHtRKwwJiCJIm+wXMUGsNCxTzADHd
X-Gm-Gg: AY/fxX4HL9Eqlq4Z6rSdPmoWjJkChkNh1KsPCeKlJHtvvrr0MJU5sXlHptoKupfLSmM
	npzvmBjKgTRgD2aJkb16PoIKD/8XiEBraQYDdBLkaZOYraAEDz5h9TxUEuotsyqkaRyxGe7Kkqo
	oVTKBYT1qDAOTtRthYP36CDCgC6EnYPVR1M4mv4ky3go6j6zPxJ5Sgl3YDxCs8ryfi
X-Received: by 2002:a17:90b:590c:b0:34c:f8e6:5ec1 with SMTP id 98e67ed59e1d1-35109163a89mr3116115a91.35.1768406068154;
        Wed, 14 Jan 2026 07:54:28 -0800 (PST)
X-Received: by 2002:a17:90b:590c:b0:34c:f8e6:5ec1 with SMTP id
 98e67ed59e1d1-35109163a89mr3116054a91.35.1768406067530; Wed, 14 Jan 2026
 07:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com> <202601140749.5TXm5gpl-lkp@intel.com>
In-Reply-To: <202601140749.5TXm5gpl-lkp@intel.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 14 Jan 2026 16:54:15 +0100
X-Gm-Features: AZwV_Qg5JTJCQi1Wwfd0jbkgP1qN1I8qkJH4vIis9H-XSIO4o_clOB-LFig_dcA
Message-ID: <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: kernel test robot <lkp@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Long Li <longli@microsoft.com>, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 00:13, kernel test robot <lkp@intel.com> wrote:
>
> Hi Bobby,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/virtio-set-skb-owner-of-virtio_transport_reset_no_sock-reply/20260113-125559
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20260112-vsock-vmtest-v14-1-a5c332db3e2b%40meta.com
> patch subject: [PATCH net-next v14 01/12] vsock: add netns to vsock core
> config: x86_64-buildonly-randconfig-004-20260113 (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601140749.5TXm5gpl-lkp@intel.com/
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> >> WARNING: modpost: net/vmw_vsock/vsock: section mismatch in reference: vsock_exit+0x25 (section: .exit.text) -> vsock_sysctl_ops (section: .init.data)

Bobby can you check this report?

Could be related to `__net_initdata` annotation of `vsock_sysctl_ops` ?
Why we need that?

Thanks,
Stefano


