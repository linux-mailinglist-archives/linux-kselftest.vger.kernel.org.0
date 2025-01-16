Return-Path: <linux-kselftest+bounces-24612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35659A12FF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 01:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4021888B6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 00:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51372E634;
	Thu, 16 Jan 2025 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hel8M9I3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406372BD04;
	Thu, 16 Jan 2025 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987455; cv=none; b=SnbvPY0fOYA2GCAy2cy5D/io7lDO01PrMBgPjo2qxPkPeU0AWG2GWAvB5hFCaH56EBswI8DRNb2hWOJnxQLTP+yvJV8hHFG4F8n7FjEo6rMpFu0TQnphIRVql/hfhRoSm5Qq5vqEiuqxHW9QGxKbzLIq+qUcMjG/a0PlojKYVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987455; c=relaxed/simple;
	bh=PYir3hZgPX8OvD6YhIBgI0czu3UhcZDjTDPSK3P2fg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc4ZItXd7M0pT3z73FLH5oPW9n50UESimoLDPFjljNqNLOyH9buIL1u4YYNxCSHMZ2XJRljf6ZqoY1cDAJQA06KIQkIR86+Ps+mFb/cFIxC1JHhJEOLfF+AxdgwNLaAkCktr3Xo9FevigLToCZFH3tf4Q8qbb4Ydz3U9AhVfTlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hel8M9I3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2167141dfa1so6720505ad.1;
        Wed, 15 Jan 2025 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987453; x=1737592253; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nbDhewnz6sF7NAjuh/IG2morMwwWY78lrdk+Dwk6HUA=;
        b=Hel8M9I3dAErh9angR1zqinHYGNjEU0aK4hC+TqI+cQYAmWzayeC/+yC9aS5f0x2Nf
         xpvgqQ4dQq5CawwT5xjso8xD+yF8hP8sBCjI7Eukxkf0UJHr0Ow8NwjClwgcE8ZL13OL
         icT0qZSioRvJpJVXrLDW76LAY9nF+IAOWJKtfa+wuwoDFnAyijiTVBn60a3ZDnBsbr9u
         +CSFcS7WHAfAr9JzqLRpn9Efpkt/yVJioYXmRMWYsS3Q+cczyKvb8keHHtvsig4vpU4j
         tfnUVNEhMGtjnzEDhlvgcvjvKK4mUP95Usa1ZzBXN7s2mT7LgQEBSeVpgRKv8Nf88Ul5
         2c4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987453; x=1737592253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbDhewnz6sF7NAjuh/IG2morMwwWY78lrdk+Dwk6HUA=;
        b=j/ZDChqQca0fY0DWjvTudoCrh5BBnBNfpY5JUVG4aMwanHm32BVgjpTS4/2h5+piii
         0r9+bvwn2HhpFG9GsnOWKahjnQ4jl6YwhuIo7I53WfprkycZBP5/sRZFIlGQzAgkg9WV
         UFh466DCRDS8nfbJ1OXEBT76UlS4RzNRdy+h0YhfvtYjr+D6MOYwNWQbS+lb4+lRzCKZ
         V+T4j4gPZngXzkLfl2btNiddu2padUdYAg4T8X28NxMzTP+mEHyB41eYLer4OoRBft8z
         X7W99PyQepJq5SsL7uvCJml+jVhUYzL/DhMmcdHA6k3eCTMCJTJrzOM73aILI4qEnqUL
         sI7A==
X-Forwarded-Encrypted: i=1; AJvYcCUNPvWi9Zn33vH3Lyo4RZhcQHo4awbi73kvJzpPYF2ra1VxX2j92MStcgmemOtoNAzBMs3R+zWGkfe/vkZYb/fi@vger.kernel.org, AJvYcCWN7STl4StJSKyGVW5h6TRxV5kn8MVn1kM23pL5Dmk8sAy6GQUDHUHDpM96hO5oFPGHoK05Ih9J@vger.kernel.org, AJvYcCWpP4EKLFA4EzYwLLOcCg58MZBFrQtMbV4S1irba9g0xczn8P3Ax8L+UMY8J5XnRDXc+K8=@vger.kernel.org, AJvYcCX2ym9hz54sA/qR2j136lv9J4C+mpvDmS3BpybozNLxu7bDjXf8lGNh1CklD/8SQi5w98y+8LHgocgP@vger.kernel.org, AJvYcCXOCE3Vmb/HQkP0yFEAdKTi6Eqzcb3FQZNhxHa1DXWUx61QWBFW5HMxkEGv7RtAzU36QIyjim6oiymSD9Ge@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6sJ2DlmYqMampKDFjosko45acc0uv4q4okSwxvxGnrH9+mad
	+PN6xMJzObC4bhHZzFzR8nwyLTGtA95zP7uml3jfbwZBBZyrWi4=
X-Gm-Gg: ASbGncu2d7BeZCdl2MPRo2UU90EwkshvrL/dKFTjK5Ant4Yu0o0RzJbbfrCYr7D9ybu
	KoaZrpMxvBUZBx8ia+eoac8XoTFi2rCR5wz/R+OYLUhYeUQEmcTqguj+LuPboD7HEGowWHWJdxo
	nBddCM/HQTs4vlHy1KpJNsHyZ7dvTlBo6f6QLm7HdxMK31qZ+uQp01/9/B+XXlPp6A/Iu8W6pgV
	V4uCXfog/UT6Aiz5cIIchThJFH7E5W8ih80DD41lOvhMsvLIHmXEjAI
X-Google-Smtp-Source: AGHT+IHL2kbDL71i52Tl5thJXHFKE0VJJEHYy6lN0jWJKKjChbh+K9Wolj1lEqEzzNUmnYNfgO9FbQ==
X-Received: by 2002:a17:903:2410:b0:216:2aec:2d54 with SMTP id d9443c01a7336-21bf077dbc9mr79922565ad.8.1736987453496;
        Wed, 15 Jan 2025 16:30:53 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f6d7sm88927685ad.52.2025.01.15.16.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:30:53 -0800 (PST)
Date: Wed, 15 Jan 2025 16:30:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [PATCH bpf-next v5 2/4] selftests/bpf: Add launch time request
 to xdp_hw_metadata
Message-ID: <Z4hTPNEGreEo6igW@mini-arch>
References: <20250114152718.120588-1-yoong.siang.song@intel.com>
 <20250114152718.120588-3-yoong.siang.song@intel.com>
 <e273b1f1-868f-440e-b226-84b493ef7ee2@iogearbox.net>
 <PH0PR11MB58300DA3845D1E3F788C4FC8D8192@PH0PR11MB5830.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB58300DA3845D1E3F788C4FC8D8192@PH0PR11MB5830.namprd11.prod.outlook.com>

On 01/15, Song, Yoong Siang wrote:
> On Wednesday, January 15, 2025 10:57 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> >On 1/14/25 4:27 PM, Song Yoong Siang wrote:
> >[...]
> >> +	/* Add mqprio qdisc with TC and hardware queue one-to-one mapping */
> >> +	char map[256] = {0};
> >> +	char queues[256] = {0};
> >> +
> >> +	for (i = 0; i < rxq; i++) {
> >> +		char buf[8];
> >> +
> >> +		snprintf(buf, sizeof(buf), "%d ", i);
> >> +		strcat(map, buf);
> >> +
> >> +		snprintf(buf, sizeof(buf), "1@%d ", i);
> >> +		strcat(queues, buf);
> >> +	}
> >> +	run_command("sudo tc qdisc add dev %s handle 8001: parent root mqprio
> >num_tc %d map %s queues %s hw 0",
> >> +		    ifname, rxq, map, queues);
> >
> >Fyi, above triggers selftest build errors:
> >
> >   xdp_hw_metadata.c: In function ‘main’:
> >   xdp_hw_metadata.c:763:45: error: ‘%d’ directive output may be truncated
> >writing between 1 and 10 bytes into a region of size 8 [-Werror=format-
> >truncation=]
> >     763 |                 snprintf(buf, sizeof(buf), "%d ", i);
> >         |                                             ^~
> >     TEST-OBJ [test_progs] arg_parsing.test.o
> >   xdp_hw_metadata.c:763:44: note: directive argument in the range [0,
> >2147483646]
> >     763 |                 snprintf(buf, sizeof(buf), "%d ", i);
> >         |                                            ^~~~~
> >   xdp_hw_metadata.c:763:17: note: ‘snprintf’ output between 3 and 12 bytes into
> >a destination of size 8
> >     763 |                 snprintf(buf, sizeof(buf), "%d ", i);
> >         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   xdp_hw_metadata.c:766:47: error: ‘%d’ directive output may be truncated
> >writing between 1 and 10 bytes into a region of size 6 [-Werror=format-
> >truncation=]
> >     766 |                 snprintf(buf, sizeof(buf), "1@%d ", i);
> >         |                                               ^~
> >   xdp_hw_metadata.c:766:44: note: directive argument in the range [0,
> >2147483646]
> >     766 |                 snprintf(buf, sizeof(buf), "1@%d ", i);
> >         |                                            ^~~~~~~
> >   xdp_hw_metadata.c:766:17: note: ‘snprintf’ output between 5 and 14 bytes into
> >a destination of size 8
> >     766 |                 snprintf(buf, sizeof(buf), "1@%d ", i);
> >         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Thanks for pointing this out.
> Btw, do you know which build command will trigger these errors?
> I am using "make -C tools/testing/selftests/bpf" but cannot
> reproduce the build error.
> 
> Thanks & Regards
> Siang

Last time I used the following to reproduce similar issues on my side:

make -C tools/testing/selftests TARGETS="bpf" LLVM=1 USERCFLAGS="-Wformat-truncation"

You can also try to use something like asprintf instead of managing the buffer
sizes manually.

