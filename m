Return-Path: <linux-kselftest+bounces-25088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E9A1B4F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 12:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5395116CCD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763EE21B19E;
	Fri, 24 Jan 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cu2vIQWJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE664A1D
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737719152; cv=none; b=UAZt+yDHpyzk9i7LMOn3J//B82VvRdi4dIs4DebVt14P2/aph8LcEoRCYhYvNb5fnQC08AoLCkTX/j3Ne/9XIzjrPNC+TYpp4+J50PemVjaXjM1Mom+m0Y+2Q2bOsAuYxIXZmCMlmYGT93xemwLD2CdjaclZPsFCvjXSPIRnqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737719152; c=relaxed/simple;
	bh=zW/EazKbI+/IIPptYdIXFZX/gpcmxVKJO/Qx43m8AGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kaHP3nSS4pnkykjnJSmrDZ5IcJHJ9nN5MV17DHnYmQBtYUWCLMoqpD6Pc/jMU0lJ8YoQpaKd3BWIP/WOmyhspezn5wc5AwF4ggaAzXYCEVJMp1UxR42wt9HXvlyNYGkghSbbxeSBZCm/0/U9c9+GYgfILqOG6v4orOVzIcfE3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cu2vIQWJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737719149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odeNkl2pdZWzjMRmLzJX8QVcRedjnH492ZzohS0yuak=;
	b=Cu2vIQWJV6udf4pen1fTULF+o1bybtBaB4+ZGld6+Zt6xyKEwgRI0EZ5BBp94YmA+Z/UXA
	AlcImlcJ2YiXjcJBPp2otQ87iyaZzfr6hdyFqrklqTIUrie0qlKOgkPEG6c4oui//FKxQM
	uj9hXrA0mLZuNM5QO6hdDtjkAFc4uek=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-VTdXneXqMNqoNoYoE9rhtg-1; Fri, 24 Jan 2025 06:45:46 -0500
X-MC-Unique: VTdXneXqMNqoNoYoE9rhtg-1
X-Mimecast-MFC-AGG-ID: VTdXneXqMNqoNoYoE9rhtg
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so1595756a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 03:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737719145; x=1738323945;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odeNkl2pdZWzjMRmLzJX8QVcRedjnH492ZzohS0yuak=;
        b=NHEvjNTyIQ3M0UH/zNnSLUArOImFmy9yuhkEhCDSNHo/H3K0brw5rA86eVQ6y3Cblm
         QGiCPXxiSjr1ijxBYqWruDEn44C6fD0r4q5oQu0Jhg/XSCe6SgRONr08IBKbnX6rUvwk
         ucggrHvPMoF/b1CQRZHxblH8EQNr+YCoxAHxT9AOmXjy2ZbvKKg0YKDnTdz+XzkX565H
         tg6dNRi2LXGP6LjjfsFbCPLxdu/886BinDlEdOylX4A5f5NrF9kWEkRNDNzzNZfPK002
         tJ3VjLW/HsyUn9/UooUwJGwOL6Pq1OXDCe472UG1jwuFdSHe3otvOsLPZS6EZT/N/i3v
         M4UA==
X-Forwarded-Encrypted: i=1; AJvYcCX5L+wWVqfuC4iL9X+ExFJrktgiZQ3BCLjELBBiRdYjBoBQAk583l3bb1PvgL0zSd2IbZM/oWzi3T0A5ipbHVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJ3OtZHDjfY6Bqm9KpjX612e3DqVmnxFLk5xGn8Ymw/rzZhXs
	b1D08mBOCz8FO1ZfHTCUx/96EHDSDcUnVROB6iEelefnB5zDj9cTdOg8R2wocqzrXOru0P0wGdM
	QyiguJkXqBEgzy7qWePavwagAdfW6DkL7zVmgScK5fS/WY/AQvc0Ag7jhedkEZ+gGJw==
X-Gm-Gg: ASbGncs0+juJxCSSoC1Gy7+IDZppJs/SyE17vdWlnzSfXSxhdcJoeemf3ziSiWaM9vi
	uHFk6Jrbky89vfU9/ENMB7pIi5ZvjdUGwjyYfLqcmmlkwZ6vVXMup1RbnUrqzZZ7VBX77WtdKmQ
	fgbMEFntH1qP8D4Smxu0XvnaSXjiwWq63GLD1LBAarIui3wwUc44nO6VzOI7W4P82BzGrTXvMrd
	14Has/+oK5Oe7Hwet8XxIqUPLDRSrboGQe4/zHxSY/TSV26/7BYuuYOMlSUn72xRyOifw+LOIDo
	6XJos1hd7KgMJ/vC010=
X-Received: by 2002:a05:6402:1e8e:b0:5dc:1059:6b2 with SMTP id 4fb4d7f45d1cf-5dc105a5ec1mr11805720a12.7.1737719144861;
        Fri, 24 Jan 2025 03:45:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeWFYBPETVo309BerlvPgux0XnsYsjMKjnLErW6dJ05V2oA4Fpf2Q3nZFN4K3N5AK1bx4cSA==
X-Received: by 2002:a05:6402:1e8e:b0:5dc:1059:6b2 with SMTP id 4fb4d7f45d1cf-5dc105a5ec1mr11805656a12.7.1737719144333;
        Fri, 24 Jan 2025 03:45:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760ab1d7sm117046766b.109.2025.01.24.03.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:45:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9DF17180AA6E; Fri, 24 Jan 2025 12:45:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, Florian Bezdeka
 <florian.bezdeka@siemens.com>
Cc: "Song, Yoong Siang" <yoong.siang.song@intel.com>, "Bouska, Zdenek"
 <zdenek.bouska@siemens.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem
 de Bruijn <willemb@google.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Damato,
 Joe" <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>,
 Daniel Jurgens <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
 <xdp-hints@xdp-project.net>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v6 4/4] igc: Add launch time
 support to XDP ZC
In-Reply-To: <Z5KdSlzmyCKUyXTn@mini-arch>
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
 <20250116155350.555374-5-yoong.siang.song@intel.com>
 <AS1PR10MB5675499EE0ED3A579151D3D3EBE02@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <PH0PR11MB583095A2F12DA10D57781D18D8E02@PH0PR11MB5830.namprd11.prod.outlook.com>
 <ea087229cc6f7953875fc69f1b73df1ae1ee9b72.camel@siemens.com>
 <Z5KdSlzmyCKUyXTn@mini-arch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 Jan 2025 12:45:42 +0100
Message-ID: <87bjvwqvtl.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stanislav Fomichev <stfomichev@gmail.com> writes:

> On 01/23, Florian Bezdeka wrote:
>> Hi all,
>> 
>> On Thu, 2025-01-23 at 16:41 +0000, Song, Yoong Siang wrote:
>> > On Thursday, January 23, 2025 11:40 PM, Bouska, Zdenek <zdenek.bouska@siemens.com> wrote:
>> > > 
>> > > Hi Siang,
>> > > 
>> > > I tested this patch series on 6.13 with Intel I226-LM (rev 04).
>> > > 
>> > > I also applied patch "selftests/bpf: Actuate tx_metadata_len in xdp_hw_metadata" [1]
>> > > and "selftests/bpf: Enable Tx hwtstamp in xdp_hw_metadata" [2] so that TX timestamps
>> > > work.
>> > > 
>> > > HW RX-timestamp was small (0.5956 instead of 1737373125.5956):
>> > > 
>> > > HW RX-time:   595572448 (sec:0.5956) delta to User RX-time sec:1737373124.9873 (1737373124987318.750 usec)
>> > > XDP RX-time:   1737373125582798388 (sec:1737373125.5828) delta to User RX-time sec:0.0001 (92.733 usec)
>> > > 
>> > > Igc's raw HW RX-timestamp in front of frame data was overwritten by BPF program on
>> > > line 90 in tools/testing/selftests/bpf: meta->hint_valid = 0;
>> > > 
>> > > "HW timestamp has been copied into local variable" comment is outdated on
>> > > line 2813 in drivers/net/ethernet/intel/igc/igc_main.c after
>> > > commit 069b142f5819 igc: Add support for PTP .getcyclesx64() [3].
>> > > 
>> > > Workaround is to add unused data to xdp_meta struct:
>> > > 
>> > > --- a/tools/testing/selftests/bpf/xdp_metadata.h
>> > > +++ b/tools/testing/selftests/bpf/xdp_metadata.h
>> > > @@ -49,4 +49,5 @@ struct xdp_meta {
>> > >                __s32 rx_vlan_tag_err;
>> > >        };
>> > >        enum xdp_meta_field hint_valid;
>> > > +       __u8 avoid_IGC_TS_HDR_LEN[16];
>> > > };
>> > > 
>> > 
>> > Hi Zdenek Bouska, 
>> > 
>> > Thanks for your help on testing this patch set.
>> > You are right, there is some issue with the Rx hw timestamp,
>> > I will submit the bug fix patch when the solution is finalized,
>> > but the fix will not be part of this launch time patch set.
>> > Until then, you can continue to use your WA.
>> 
>> I think there is no simple fix for that. That needs some discussion
>> around the "expectations" to the headroom / meta data area in front of
>> the actual packet data.
>
> By 'simple' you mean without some new UAPI to signal the size of that
> 'reserved area' by the driver? I don't see any other easy way out as well :-/

Yeah, I don't think we can impose UAPI restrictions on the metadata area
at this point. I guess the best we can do is to educate users that they
should call the timestamp kfunc before they modify the metadata?

-Toke


