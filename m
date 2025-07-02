Return-Path: <linux-kselftest+bounces-36345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB55AF5DFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C93A3B4F4F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37800246791;
	Wed,  2 Jul 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+CWOYPG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6D3196C7;
	Wed,  2 Jul 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472251; cv=none; b=qQ5SKBct4kdKx83BQ5v0a2TCNQklQOItdO3sEGJUzAjhTQ6KEH04MqHlCaj/q7Yka7UNnJ1CBmUfjN9Pz1zeBdV3p7UvsY/fxRU39qVdFQoYrt2U1GNqHkOVrGpntRZcahaUFGExRj8eo0HnRBnenNQfsB/DoGTt6dlZTx5RrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472251; c=relaxed/simple;
	bh=V7ocvZ1MzRTMgmZ5TCXNgMiB58Py13evA/lkbx68+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUiT+3DBZxgKqAlhaO3b9PkKwyBNcToie+gIwYKnG48VGfgJCbgamchLCIqjHjS8ZOckHplI0BpqtgH7pNJEnBsdxy2H9iS+pwObxrMS1qVY334KpEZG+eyxtn6PQnwBtJItWZBaKi9gjIeOVH2MKJalXDt2ECQHwMWqhEiLAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+CWOYPG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso636846b3a.0;
        Wed, 02 Jul 2025 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751472249; x=1752077049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2nzxIAHzM2zCpkXYgT63kjyxekr2mJ2gHQXxs6/nCg=;
        b=A+CWOYPGlQ/EgOBwLFiS6R6YTjSYDKPAUc5o30pqlS6X38Qqncgt2G6hoV66I0n0A7
         WtwSiETjpjQypKyj2w9McUTtibV78fTcGHxw5YWmvH08u+244PSgqGW3+BllPTwttYQb
         Q5ZOIG/KiOZn+PLNCovnX46fHyOlnrLZIWsU+CWryOOkoy5PPC9/Vl8R9kBL9U1C2gXG
         URwfS6iAVDvF55oMJKzcmqdLEw+o8BkQAPCwBErAnAtU1A6MG2t2ovSRa7qmDcxt18RS
         UqjVNs6KAIVGOFNZOySYAPCMvfkZF9c8iVgFH5uX7VpWRvNoQxkEjnxqKoCUKTjQx8tw
         DUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751472249; x=1752077049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2nzxIAHzM2zCpkXYgT63kjyxekr2mJ2gHQXxs6/nCg=;
        b=h9kgT4zOeVClI0C8voMimID55onGXULeSNZBUHaA2znXF2uvx8AdWYYDFFPjfxnmqZ
         QChjqPgvNabIelGoAmewIMiDqjD4avuDcFW9eyvRCoJjk0UjrnUgdBYn36c8CGIFXzj8
         CTssfcvvv7tzTQyCcr5ENipLsydLvK/MJrZDzvKEVlWUOehF4y7uxt226m7nPXIi5Bi6
         BvCyracsHEGok8JJwKj2BfBUUEnJo6t4xYgdasOrvTlkq8B0hSrNYjNri1BQxw49fjIq
         ba8E/c25gq3MNCF2rmgP8qD3nbHAy0aXigWdzKUiHFFpzfKnAjGXQzYwiqMRl3d3Pabz
         18sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgbt6cqFPU+NJmUANeUsJ9fYK2PD4Z0H5s4QgHuPdg1GLA3AyVujybm9ytpkBKj5Jwlah6oh1F@vger.kernel.org, AJvYcCV4HKOPlt7ud/9KV3eQPwoKXB/wW1eiVn1ySuaEDYTBj6Cte/A/+MaNc5G3yDXIzCoesVp5CLX7c4dm4Qgc@vger.kernel.org, AJvYcCVcfWOAmqMQ1C7jQCkuttZAlexe/l8p2tBDwKIGWzeaFlNmWHf2EN2sJbwXtxfS68tKFk4=@vger.kernel.org, AJvYcCX1rtvY35lKT8qO2pXoYO8v+gbNq84qa/C7biwpt5aP9JW9PuPZoYrtJ75SYJC/v7GpwlPkS+iQhkCa9K4mZ1E+@vger.kernel.org, AJvYcCXcXhPeB/4c7yW5aiQKWv+OhUGxKrO5aiDdBUrTlmPurgS5omQ6ObkprWngme1dseYG8N0TB7kucq+w@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcCnLC8/27Nwsg4iHQiAB7MBgsN3oFgDc0ea/li/AqwCYKuQF
	OE2PWndCjGgF3zbiqqmO5plQRREMrdCDLPa+Tp1xK2TkThnOGNgNAeU=
X-Gm-Gg: ASbGncuCXNSf4UEno5/Pr1ZhtlKuvSc5z0x9BGZvj+QX2Q7I+9BlEn/vFje28BUAkuX
	6MpfNV8e7Lz6Y6Fwr4Zc/jdBQanmvM3iMKDUEkBaSL5LleJxOyeliKWn5Su+fbOYNwMFANbv51h
	9ogDuADCCYltVbVW/zCeeQwIuAIRkTQQY1rybtFtYkiF3q5hM8i4Bt7nLAyocRaLiVL3GBf60UQ
	XyilHAvAVjnwAj22oiQHsWJBYJrDCchQJDxjTcG9wHSZ47XQQJItE8czcwOkaFr7RkmVH9LXYgA
	VDDujf5ZAK7XXLXjDbHXQTTPVpFf5xUq6z8i4j46c7wgd3q4ucCJTsIBA5nl8zsJZviPWiXF8CR
	4gM6jCeWqxdEU3BdHdV6XeKE=
X-Google-Smtp-Source: AGHT+IECN/3euiEQr+MyKhdKeZaMnO25R8NGOtZzSFB4uCv1hJ23ZUZo4MgpnbG8A79ErgQtwmmAow==
X-Received: by 2002:a05:6a00:4b0f:b0:749:14b5:921f with SMTP id d2e1a72fcca58-74b50f6847emr5230413b3a.18.1751472248385;
        Wed, 02 Jul 2025 09:04:08 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af55786e3sm14463411b3a.72.2025.07.02.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:04:07 -0700 (PDT)
Date: Wed, 2 Jul 2025 09:04:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Enhance XDP Rx Metadata
 Handling
Message-ID: <aGVYdjDKNBdWdrQ8@mini-arch>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
 <20250701042940.3272325-3-yoong.siang.song@intel.com>
 <aGQNWXe6FBks8D3U@mini-arch>
 <IA3PR11MB925416396633E361F37E819DD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <IA3PR11MB9254C961FD048793FD0013EAD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <aGVN01flIJzvCo6S@mini-arch>
 <IA3PR11MB92541178AAF28F03639A9435D840A@IA3PR11MB9254.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB92541178AAF28F03639A9435D840A@IA3PR11MB9254.namprd11.prod.outlook.com>

On 07/02, Song, Yoong Siang wrote:
> On Wednesday, July 2, 2025 11:19 PM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >On 07/02, Song, Yoong Siang wrote:
> >> On Wednesday, July 2, 2025 10:23 AM, Song, Yoong Siang
> ><yoong.siang.song@intel.com> wrote:
> >> >On Wednesday, July 2, 2025 12:31 AM, Stanislav Fomichev
> ><stfomichev@gmail.com>
> >> >wrote:
> >> >>On 07/01, Song Yoong Siang wrote:
> >> >>> Introduce the XDP_METADATA_SIZE macro to ensure that user applications can
> >> >>> consistently retrieve the correct location of struct xdp_meta.
> >> >>>
> >> >>> Prior to this commit, the XDP program adjusted the data_meta backward by
> >> >>> the size of struct xdp_meta, while the user application retrieved the data
> >> >>> by calculating backward from the data pointer. This approach only worked if
> >> >>> xdp_buff->data_meta was equal to xdp_buff->data before calling
> >> >>> bpf_xdp_adjust_meta.
> >> >>>
> >> >>> With the introduction of XDP_METADATA_SIZE, both the XDP program and user
> >> >>> application now calculate and identify the location of struct xdp_meta from
> >> >>> the data pointer. This ensures the implementation remains functional even
> >> >>> when there is device-reserved metadata, making the tests more portable
> >> >>> across different NICs.
> >> >>>
> >> >>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> >> >>> ---
> >> >>>  tools/testing/selftests/bpf/prog_tests/xdp_metadata.c |  2 +-
> >> >>>  tools/testing/selftests/bpf/progs/xdp_hw_metadata.c   | 10 +++++++++-
> >> >>>  tools/testing/selftests/bpf/progs/xdp_metadata.c      |  8 +++++++-
> >> >>>  tools/testing/selftests/bpf/xdp_hw_metadata.c         |  2 +-
> >> >>>  tools/testing/selftests/bpf/xdp_metadata.h            |  7 +++++++
> >> >>>  5 files changed, 25 insertions(+), 4 deletions(-)
> >> >>>
> >> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> >> >>b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> >> >>> index 19f92affc2da..8d6c2633698b 100644
> >> >>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> >> >>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> >> >>> @@ -302,7 +302,7 @@ static int verify_xsk_metadata(struct xsk *xsk, bool
> >> >>sent_from_af_xdp)
> >> >>>
> >> >>>  	/* custom metadata */
> >> >>>
> >> >>> -	meta = data - sizeof(struct xdp_meta);
> >> >>> +	meta = data - XDP_METADATA_SIZE;
> >> >>>
> >> >>>  	if (!ASSERT_NEQ(meta->rx_timestamp, 0, "rx_timestamp"))
> >> >>>  		return -1;
> >> >>> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> >> >>b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> >> >>> index 330ece2eabdb..72242ac1cdcd 100644
> >> >>> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> >> >>> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> >> >>> @@ -27,6 +27,7 @@ extern int bpf_xdp_metadata_rx_vlan_tag(const struct
> >> >>xdp_md *ctx,
> >> >>>  SEC("xdp.frags")
> >> >>>  int rx(struct xdp_md *ctx)
> >> >>>  {
> >> >>> +	int metalen_used, metalen_to_adjust;
> >> >>>  	void *data, *data_meta, *data_end;
> >> >>>  	struct ipv6hdr *ip6h = NULL;
> >> >>>  	struct udphdr *udp = NULL;
> >> >>> @@ -72,7 +73,14 @@ int rx(struct xdp_md *ctx)
> >> >>>  		return XDP_PASS;
> >> >>>  	}
> >> >>>
> >> >>> -	err = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
> >> >>
> >> >>[..]
> >> >>
> >> >>> +	metalen_used = ctx->data - ctx->data_meta;
> >> >>
> >> >>Is the intent here to query how much metadata has been consumed/reserved
> >> >>by the driver?
> >> >Yes.
> >> >
> >> >>Looking at IGC it has the following code/comment:
> >> >>
> >> >>	bi->xdp->data += IGC_TS_HDR_LEN;
> >> >>
> >> >>	/* HW timestamp has been copied into local variable. Metadata
> >> >>	 * length when XDP program is called should be 0.
> >> >>	 */
> >> >>	bi->xdp->data_meta += IGC_TS_HDR_LEN;
> >> >>
> >> >>Are you sure that metadata size is correctly exposed to the bpf program?
> >> >You are right, the current igc driver didn't expose the metadata size correctly.
> >> >I submitted [1] to fix it.
> >> >
> >> >[1] https://patchwork.ozlabs.org/project/intel-wired-
> >> >lan/patch/20250701080955.3273137-1-yoong.siang.song@intel.com/
> >> >
> >> >>
> >> >>My assumptions was that we should just unconditionally do
> >bpf_xdp_adjust_meta
> >> >>with -XDP_METADATA_SIZE and that should be good enough.
> >> >
> >> >The checking is just for precautions. No problem if directly adjust the meta
> >> >unconditionally.
> >> >That will save processing time for each packet as well.
> >> >I will remove the checking and submit v2.
> >> >
> >> >Thanks & Regards
> >> >Siang
> >> >
> >>
> >> Hi Stanislav Fomichev,
> >>
> >> I submitted v2. But after that, I think twice. IMHO,
> >> err = bpf_xdp_adjust_meta(ctx, (int)(ctx->data - ctx->data_meta -
> >XDP_METADATA_SIZE));
> >> is better than
> >> err = bpf_xdp_adjust_meta(ctx, -(int)XDP_METADATA_SIZE);
> >> because it is more robust.
> >>
> >> Any thoughts?
> >
> >My preference is on keeping everything as is and converting to
> >-(int)XDP_METADATA_SIZE. Making IGC properly expose (temporary) metadata len
> >is a user visible change, not sure we have a good justification?
> 
> Thank you for your feedback. I agree that we don't have a strong justification
> for making the metadata length user-visible at this time. I concur with your
> preference to keep everything as is and proceed with -(int)XDP_METADATA_SIZE.
> 
> Btw, do you think whether my first patch which changes the documentation is
> still needed or not?

Yes, the documentation is super useful, let's keep it!

