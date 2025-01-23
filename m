Return-Path: <linux-kselftest+bounces-25034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C848FA1AAAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 20:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879663A1FB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 19:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B6193073;
	Thu, 23 Jan 2025 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsFEo5hJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C6192B76;
	Thu, 23 Jan 2025 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661773; cv=none; b=CqrHVrT+TNDISmOWB2x4rviI4olxFCmZxApVQOcbo84fALJUwL6lBqSOXRCsFfrYRCFiCNI5MVqfL4HtfFkJ8NAMMxzmOz+LlB7xuwjx7iI41AxcYxLIfii7lvl+RUXWGf6LRTz+gDDvxMgmywaXh4xAAgqyiM/u2WqMoXQl2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661773; c=relaxed/simple;
	bh=QdjY/uftDkB8P39mPx/Ss9DRZ+cCm2+3VhpA3nLNghU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZjkXGrVBBKF3w6yavKl2wM6Ey2ltujINE5/p6HNiA2yCCzaswBK0QCanfkBRG29k/Z6LWWc+JK4MGDz4VtVyCgQJ+w36l20J1iMv2615a9uNldua9ALzkDmhNLnsAg8XT6t2CAZOnqkHMeyT/ucj3tsUSAkRKl3g3IfDxcBkHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsFEo5hJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21661be2c2dso23639035ad.1;
        Thu, 23 Jan 2025 11:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661771; x=1738266571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qLickY1e0ujLI7bpuAPKBg3ra7SxF8sIpaNTGdpk/E=;
        b=RsFEo5hJqYugvOSQrowfLPJ6Z5SBBNDr15AnBA7FPIR+NVQTrE8NoPRNB1CHzIO4vq
         PGfDnPbemm0GQDqX0BCgYRTbpILl4cUK3O9icAPwVp7SOO3DLm8M/miq+mzd7HV9vF34
         ePuhLdAiUBMLkcWXbzLYN+OYZeTZOUvDnRwP94Kz9KQEFX9vxKOz5oTiK6s3NX71ZIQr
         5ciGD7vCquztv30NVveMWXQ5ccTctDFc/GXTm/u5cISc4UaenuNFSsFSuO0KUm8dXrLt
         PObZxcIWvyvCgi/hudoZy400rgLuq5mfJAHTNUh1OIVg1JjVtOaAgt90wgKVIcxmlUm6
         izZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661771; x=1738266571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qLickY1e0ujLI7bpuAPKBg3ra7SxF8sIpaNTGdpk/E=;
        b=LOlhFcxLk816c4gxqpPAi6ccPkvbpNQv+VGREzUk+SD5eb+F3fLQk5e3Lla37MaRHh
         OOlF6JWYMX+aJR1nshlRFp202e8xxgUY6zmdzNRYwqR1RBDmym6dVG9EeyID1zySy1CU
         zOiAAxy/07k2kFLz5hq6Ayoe3U6too+wzmBUDp4rB0+sZuxF/BqcGMIu033jLfpMH7Gk
         V3vmRKEYRgwB7XpF2MU0izvj0ns2/eki3aHBLKICP5OYZ1aDb/H2J3wzuEC3IaA9xl4l
         7JkGbVK536VvO8KDf+QIkfUm0pp3KzywGgYVjhFK5/i6bJ2YQ9pFx+/9+9fFWJ8mH/Tm
         5W7A==
X-Forwarded-Encrypted: i=1; AJvYcCUexellNDkI88vTT4HJq+5++kkwal/tBU+lBpA2ch1KPA+BTzwdKWyu513FEqszM0YEWWr+XFD+K05wFkJZ@vger.kernel.org, AJvYcCV9C/TgEPN4mXgA0zP0bCkzFd8QYReYjjaa2/gVSP0iPz1DVR8H08/smVuzcNN3uVoxxuz17XsnQv2t@vger.kernel.org, AJvYcCVGGn6vZFOfNIluDn9xHG9qN20itW1V5Cceh+pQBrDxd07h2atkxvMwCLiXBcF0a+vev61W/2RqCyQMG8bL9hIV@vger.kernel.org, AJvYcCWFlHb2UipgHrExqVRMJPfRYMOHfNpKfyVdxBvJTSBBWt/HbcfHXFxsC/r6Y2Lz6rU0fRg=@vger.kernel.org, AJvYcCXzNRzoSiQy6A6O23sLN1DnQ5mgm8IQx7owD54j/V57bywPS8+CHdiPsGgpkS4nwiYtlrbP1/RV@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlMOnPPJvyEzCHihCUGUcY9KWGW59za/h8Y0iT7HgqM6r2RoE
	Y6LaargX1bKHW4sWUColzk/0gxpd2fA2uci8bTuRM/TR4x6wjbw=
X-Gm-Gg: ASbGncuZXIFi9Jl00Ce7s+LCUNMFiv3O/sjBCc4q85gnyuM/GBvzuRdiuvClqsP64py
	lA6RIfLc2gGZ+KrX4LB4KBqy+E0rF18R5SmT2QvizIX4/mHWOHWgcmc8u6xMif01VCc8z/sNljp
	UfsLDgt0zRHdhOZG6RY90CgjwYB0gKrKqYmD/mKFw/lLrUCwKm4CSVSGvzu0VFqa5TfY0Mn2n8w
	be8NSWqehyi3u8/frnsGKZiP9/Yi2U9gow1J5JULHjBwJES3qsuR5zR88z61NMiqdkCP0bzH247
	2X0v
X-Google-Smtp-Source: AGHT+IESeNKwX2zcipFaXoMlvYsxaD0Oto3RCfSnVHPTxJyo13u3XHbde1U83PRnjPUOPMjYL0fFMw==
X-Received: by 2002:a17:903:988:b0:216:7ee9:220b with SMTP id d9443c01a7336-21c35530048mr461405425ad.22.1737661771206;
        Thu, 23 Jan 2025 11:49:31 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141436sm2728275ad.134.2025.01.23.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:49:30 -0800 (PST)
Date: Thu, 23 Jan 2025 11:49:30 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "Song, Yoong Siang" <yoong.siang.song@intel.com>,
	"Bouska, Zdenek" <zdenek.bouska@siemens.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Damato, Joe" <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: Re: [PATCH bpf-next v6 4/4] igc: Add launch time support to XDP ZC
Message-ID: <Z5KdSlzmyCKUyXTn@mini-arch>
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
 <20250116155350.555374-5-yoong.siang.song@intel.com>
 <AS1PR10MB5675499EE0ED3A579151D3D3EBE02@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <PH0PR11MB583095A2F12DA10D57781D18D8E02@PH0PR11MB5830.namprd11.prod.outlook.com>
 <ea087229cc6f7953875fc69f1b73df1ae1ee9b72.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea087229cc6f7953875fc69f1b73df1ae1ee9b72.camel@siemens.com>

On 01/23, Florian Bezdeka wrote:
> Hi all,
> 
> On Thu, 2025-01-23 at 16:41 +0000, Song, Yoong Siang wrote:
> > On Thursday, January 23, 2025 11:40 PM, Bouska, Zdenek <zdenek.bouska@siemens.com> wrote:
> > > 
> > > Hi Siang,
> > > 
> > > I tested this patch series on 6.13 with Intel I226-LM (rev 04).
> > > 
> > > I also applied patch "selftests/bpf: Actuate tx_metadata_len in xdp_hw_metadata" [1]
> > > and "selftests/bpf: Enable Tx hwtstamp in xdp_hw_metadata" [2] so that TX timestamps
> > > work.
> > > 
> > > HW RX-timestamp was small (0.5956 instead of 1737373125.5956):
> > > 
> > > HW RX-time:   595572448 (sec:0.5956) delta to User RX-time sec:1737373124.9873 (1737373124987318.750 usec)
> > > XDP RX-time:   1737373125582798388 (sec:1737373125.5828) delta to User RX-time sec:0.0001 (92.733 usec)
> > > 
> > > Igc's raw HW RX-timestamp in front of frame data was overwritten by BPF program on
> > > line 90 in tools/testing/selftests/bpf: meta->hint_valid = 0;
> > > 
> > > "HW timestamp has been copied into local variable" comment is outdated on
> > > line 2813 in drivers/net/ethernet/intel/igc/igc_main.c after
> > > commit 069b142f5819 igc: Add support for PTP .getcyclesx64() [3].
> > > 
> > > Workaround is to add unused data to xdp_meta struct:
> > > 
> > > --- a/tools/testing/selftests/bpf/xdp_metadata.h
> > > +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> > > @@ -49,4 +49,5 @@ struct xdp_meta {
> > >                __s32 rx_vlan_tag_err;
> > >        };
> > >        enum xdp_meta_field hint_valid;
> > > +       __u8 avoid_IGC_TS_HDR_LEN[16];
> > > };
> > > 
> > 
> > Hi Zdenek Bouska, 
> > 
> > Thanks for your help on testing this patch set.
> > You are right, there is some issue with the Rx hw timestamp,
> > I will submit the bug fix patch when the solution is finalized,
> > but the fix will not be part of this launch time patch set.
> > Until then, you can continue to use your WA.
> 
> I think there is no simple fix for that. That needs some discussion
> around the "expectations" to the headroom / meta data area in front of
> the actual packet data.

By 'simple' you mean without some new UAPI to signal the size of that
'reserved area' by the driver? I don't see any other easy way out as well :-/

