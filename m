Return-Path: <linux-kselftest+bounces-36339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16246AF5C99
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 17:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B6F1BC4F2B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948A430B9A6;
	Wed,  2 Jul 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/uuQ4D/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864C30B995;
	Wed,  2 Jul 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469527; cv=none; b=K0FhhwMIAT4/zhXK8BMuWihK6mV1+UM2M4LNDuy5lKurD6wjZgcl+d3A2BbcyjI3PHgHf+HrCzhQP72jGITAjuAB5v0FOltCnGHsjd6rYll3O06ORLZF9MDQUNgTqIWvmsSykxul/igQyVyTyOX9oLqnILnmJvfZMuo9oJtw6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469527; c=relaxed/simple;
	bh=o3eyvE0FZSxLk36Gq5SIwWDzbP/UZukqZgbIboPYkLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRxRrA67eBcnyTtC0YddfRBAzwJZK+rW0r7nvmTSOqNgelDkD2ZA2dSh9dAmrYOJ6owvCgyTEW341DQ+QfbyIYESNFWNYkViXZWiWKlvsuGc4YDLRCwBV1Shsi1kxSLPs6/Mt+IOun8OvuuCFL/10BJ0jTVn3ZRogQ4+lLOk9vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/uuQ4D/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e63d4b05so3054000b3a.2;
        Wed, 02 Jul 2025 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751469525; x=1752074325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WfTpr+MC7D5hMbN8aa00FoylKg/j/JmHV5iUWtrt48=;
        b=F/uuQ4D/Yx1xgm2vLhSTD6npAECIrhYsXKIAed6lwwWczu7mEP1/eyCkvRi1QUsvtA
         6Lu9DK8wDPzSLuIwxbv/PpdbhBkJq9cV52hZTHl2Nfjph6onciGfmD5nqDQVRdVmPRY9
         zwvoXZaL9fwYNx3VfWWtQ8Iwtv1RILs0hjwxggNVG+NULMXoFj3jtG3M3mGZqU598cgp
         NUKxgt1seDMbK8/zsLn0bKAfYsMA7mjtvVN3WJ6akWKw4W2a/w/3I5qZPkUEfcOMzf7E
         pqy5VoSunFppF370Nj+JgyIEDaoB2rcLwmDnnXYwuC7HqCLNr4MJh2rEdAa7J7y7nTJB
         bjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751469525; x=1752074325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WfTpr+MC7D5hMbN8aa00FoylKg/j/JmHV5iUWtrt48=;
        b=MGvplbSsBu76WXbtYuyq9FxduZuIdqb43mQ5uz9aTOfq0y89Uf8e5RBWZeYxc1IRF2
         YypzCL2TilxV4dalsNBmGghqSTZSRfSn91t8ysdfZhu0CAzOMLNkH8GPdnPdkSLMfkDC
         OpE1mIdOvA6oVPTyt3+pa/iIb43gW4rIA1mkTBzj1dm1UTMASUN/dIcOV03AkSOwarpR
         NMJv/ZEcVleSuWTvIc89Vpt9Ch8tHeHkhNqKxq+MPibSK2V064pmiMuj7+T00ZQmbQoX
         15abA1HTQtCHBqHgnfHtCmHs7giFl/cyqks4bn84ryprnJeAyCxqVHonyGpurzaq0OxJ
         pYVA==
X-Forwarded-Encrypted: i=1; AJvYcCUJjGY4qgyO+l4yL9uWjniCQg3Vy0xaTzLcUYBqrBUZAbquW+mcQiHMvoAxSiLnuAl1Zjc7Vwbk9x3nFsRV@vger.kernel.org, AJvYcCUdc97KU5vSRSYEZ4oi2PoiNALt3fnlw1K0Uzvf2lxncZzmcllHaiNXw6OsQV2AvwxLghk=@vger.kernel.org, AJvYcCV190gyW+GheBRwAW72zfEWUebSoUlKkuY73ocgz0nwHsetTrYdScdZ076sAEHrdmyIDwgVpJwm@vger.kernel.org, AJvYcCVMwP1T//DL6DP+jUzuAHiH4MoTEYspi2MkYSZbldQd99yj7VK2INMS++H8ePoUy3UBYOeVMenvnrBu@vger.kernel.org, AJvYcCXpawHnrIplWT2RDDPwzgT483+JfAsMxqGbFmpeBaGeUkCPA9nww06+2IhjcSo7aFfpLlwPGkahVY6BB7AtL4oT@vger.kernel.org
X-Gm-Message-State: AOJu0YxHiq5aLQNf/hbWYmI4rQRLyhmyvmqTUtKLS5STiyuItP0jARvr
	LN07dalY650Wl6Z76q7HxYK9rSZcZLJCrSoNuE1cg7/k/NKC7ZkU9BI=
X-Gm-Gg: ASbGnct4zxckjQgA/JSLy5yYS2fcm9gb7+M9PK/Cbl79zEnnBezryoZKnXCrCn6V91i
	p3LSVQhdkq/dRUDQ1ZVy3+XQw1C5V7b2swASHjvMv21Kmi7eYkS8sT4DoZ7hFPMyssc+hxTuvD/
	srZP371GZeMgvw/cHjjAwPuGfcBbQ5Ibblx4dgOcalBCLYZZQKRgwG3r6ngPQLxCRZU3c3DxsY5
	Y3LSfhpt/Se9Ba6pK1uoWAdZ2rMgN5cL4Oyav1s23XUrbT3F88eA/YvOYgyTTG6yRY7euJIe4RC
	5NNaYf4xDTR1EVPzBQ5SaIdEQgqzFW58c+P9pGDn+vnml+ZTZEN6uQhsD/1tj5n6QTeV7LdnFdw
	Oo0cgX2rbEuHbtye4ykoNbnQpSWLEoyPnVQ==
X-Google-Smtp-Source: AGHT+IFqg4JzfauY+XxeHTc1LYSCfLUbxmop666wkaWl715tRit7N3zBPPXoOqrKCtMSSqjKSYHLDA==
X-Received: by 2002:a05:6a00:4fc5:b0:748:3a1a:ba72 with SMTP id d2e1a72fcca58-74b513bd7b2mr4696793b3a.20.1751469524887;
        Wed, 02 Jul 2025 08:18:44 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af54099e1sm15305484b3a.18.2025.07.02.08.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:18:44 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:18:43 -0700
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
Message-ID: <aGVN01flIJzvCo6S@mini-arch>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
 <20250701042940.3272325-3-yoong.siang.song@intel.com>
 <aGQNWXe6FBks8D3U@mini-arch>
 <IA3PR11MB925416396633E361F37E819DD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <IA3PR11MB9254C961FD048793FD0013EAD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9254C961FD048793FD0013EAD840A@IA3PR11MB9254.namprd11.prod.outlook.com>

On 07/02, Song, Yoong Siang wrote:
> On Wednesday, July 2, 2025 10:23 AM, Song, Yoong Siang <yoong.siang.song@intel.com> wrote:
> >On Wednesday, July 2, 2025 12:31 AM, Stanislav Fomichev <stfomichev@gmail.com>
> >wrote:
> >>On 07/01, Song Yoong Siang wrote:
> >>> Introduce the XDP_METADATA_SIZE macro to ensure that user applications can
> >>> consistently retrieve the correct location of struct xdp_meta.
> >>>
> >>> Prior to this commit, the XDP program adjusted the data_meta backward by
> >>> the size of struct xdp_meta, while the user application retrieved the data
> >>> by calculating backward from the data pointer. This approach only worked if
> >>> xdp_buff->data_meta was equal to xdp_buff->data before calling
> >>> bpf_xdp_adjust_meta.
> >>>
> >>> With the introduction of XDP_METADATA_SIZE, both the XDP program and user
> >>> application now calculate and identify the location of struct xdp_meta from
> >>> the data pointer. This ensures the implementation remains functional even
> >>> when there is device-reserved metadata, making the tests more portable
> >>> across different NICs.
> >>>
> >>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> >>> ---
> >>>  tools/testing/selftests/bpf/prog_tests/xdp_metadata.c |  2 +-
> >>>  tools/testing/selftests/bpf/progs/xdp_hw_metadata.c   | 10 +++++++++-
> >>>  tools/testing/selftests/bpf/progs/xdp_metadata.c      |  8 +++++++-
> >>>  tools/testing/selftests/bpf/xdp_hw_metadata.c         |  2 +-
> >>>  tools/testing/selftests/bpf/xdp_metadata.h            |  7 +++++++
> >>>  5 files changed, 25 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> >>b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> >>> index 19f92affc2da..8d6c2633698b 100644
> >>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> >>> @@ -302,7 +302,7 @@ static int verify_xsk_metadata(struct xsk *xsk, bool
> >>sent_from_af_xdp)
> >>>
> >>>  	/* custom metadata */
> >>>
> >>> -	meta = data - sizeof(struct xdp_meta);
> >>> +	meta = data - XDP_METADATA_SIZE;
> >>>
> >>>  	if (!ASSERT_NEQ(meta->rx_timestamp, 0, "rx_timestamp"))
> >>>  		return -1;
> >>> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> >>b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> >>> index 330ece2eabdb..72242ac1cdcd 100644
> >>> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> >>> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> >>> @@ -27,6 +27,7 @@ extern int bpf_xdp_metadata_rx_vlan_tag(const struct
> >>xdp_md *ctx,
> >>>  SEC("xdp.frags")
> >>>  int rx(struct xdp_md *ctx)
> >>>  {
> >>> +	int metalen_used, metalen_to_adjust;
> >>>  	void *data, *data_meta, *data_end;
> >>>  	struct ipv6hdr *ip6h = NULL;
> >>>  	struct udphdr *udp = NULL;
> >>> @@ -72,7 +73,14 @@ int rx(struct xdp_md *ctx)
> >>>  		return XDP_PASS;
> >>>  	}
> >>>
> >>> -	err = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
> >>
> >>[..]
> >>
> >>> +	metalen_used = ctx->data - ctx->data_meta;
> >>
> >>Is the intent here to query how much metadata has been consumed/reserved
> >>by the driver?
> >Yes.
> >
> >>Looking at IGC it has the following code/comment:
> >>
> >>	bi->xdp->data += IGC_TS_HDR_LEN;
> >>
> >>	/* HW timestamp has been copied into local variable. Metadata
> >>	 * length when XDP program is called should be 0.
> >>	 */
> >>	bi->xdp->data_meta += IGC_TS_HDR_LEN;
> >>
> >>Are you sure that metadata size is correctly exposed to the bpf program?
> >You are right, the current igc driver didn't expose the metadata size correctly.
> >I submitted [1] to fix it.
> >
> >[1] https://patchwork.ozlabs.org/project/intel-wired-
> >lan/patch/20250701080955.3273137-1-yoong.siang.song@intel.com/
> >
> >>
> >>My assumptions was that we should just unconditionally do bpf_xdp_adjust_meta
> >>with -XDP_METADATA_SIZE and that should be good enough.
> >
> >The checking is just for precautions. No problem if directly adjust the meta
> >unconditionally.
> >That will save processing time for each packet as well.
> >I will remove the checking and submit v2.
> >
> >Thanks & Regards
> >Siang
> >
> 
> Hi Stanislav Fomichev,
> 
> I submitted v2. But after that, I think twice. IMHO, 
> err = bpf_xdp_adjust_meta(ctx, (int)(ctx->data - ctx->data_meta - XDP_METADATA_SIZE));
> is better than
> err = bpf_xdp_adjust_meta(ctx, -(int)XDP_METADATA_SIZE);
> because it is more robust.
> 
> Any thoughts?

My preference is on keeping everything as is and converting to
-(int)XDP_METADATA_SIZE. Making IGC properly expose (temporary) metadata len
is a user visible change, not sure we have a good justification?

