Return-Path: <linux-kselftest+bounces-24006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E6EA04718
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7F23A1D69
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16861F2C22;
	Tue,  7 Jan 2025 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UId9kYOU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC31D7E41;
	Tue,  7 Jan 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268616; cv=none; b=RCUtKi+85cnNjd8SKqUPvkglh/HLlAkFxJzf338svgUblmet5rv8dY+TC/Rjzq7WYXBwpbVsmXboNic6TzewiOBPWdWyMClDcsf6uZePXxZsvTMBfhtxRd2JcMDWI4F+vfaq8CiqQ1ozLPPIu1xtGcRE0LG61HYQtfcOGKXyt3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268616; c=relaxed/simple;
	bh=rq46TzVhAWlrO7ryjvb7xwfvys7fBYzRjHLnW+ZsiPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcuemZL51LSULIpSAKwm7HjwEkjrWL28arDXOzwY3RK1MAZudYA0qRHELpdmj/WYhP6XA0ozHla9A/1DCh9QCcwVonupxrOPBwwYnHYP0Mh7DMXmmGeCOhVGex+iSEXCRy1nJEXKU/Kdw5lXuiLLbNxBFqGPup2eG+EFxiJUViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UId9kYOU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21a1e6fd923so15882825ad.1;
        Tue, 07 Jan 2025 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736268613; x=1736873413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kkw8OsqKUstZ6+HR7QBUZKdgqA2L6g+toZ/3deeQ/o=;
        b=UId9kYOUs1SY1zDjWjPEnql/P0/7jA8ikfUrcCCYgdA/ix+2gEcO2ND1qys0PCkCeF
         20dMsg6ykfZqUrgCy2/yV1rjDRNEzsVSzvW5TporBj/3p6/yGZCvUhF7FrQAn44sGXr/
         uJ5IYgknBA1elkDEK3qN5BE/pEo9FAG+sYp0TNXprpAJrhbWK+sJ95H0NUv/vuesAAUG
         kJUSj+uAYm0AfEfbmQFPORpsNsqfZjThSSPCgIST226Ak46I57dBdLVnsuzd+gJ1nFrZ
         WBn8i0FmvxNl5cwVL09iwF6IYrwUpA4D+0zj9Fi2BoGXBGKcxtjPznBiMLGxLHAGDOcd
         5eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268613; x=1736873413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kkw8OsqKUstZ6+HR7QBUZKdgqA2L6g+toZ/3deeQ/o=;
        b=EtOlEr8zbJ2eUigZjZoVKlF/z6Rg/c5vep15bhHYLXP/HpSZmEvvS3nLQ5d+WemXWZ
         W0WI9oT6GJQBL0BwlQYNwClxV6PdWYpVzh4+PkhbMaeH/HXcOce8Bjk7jlTH4EB6pIsU
         ZZ4ZLWjAOak7UBVmrbFF8Jm/+zHF5facF0VuYcerwfnyARXnmbY4tggXw0pbitJD3PYm
         D5WiUzeF2CmAMB/vehViSgJ7p21eBkl/DIS/ZBwLo8nhrzxzgn/sIVh20pxZk5V4OsdJ
         SW8ZeTPtUpcPKioUCzVZbQHuMymd1xQAshBUihRpPc86h4JxJGpQ3LyDwWqCg9H8vPLR
         l3IA==
X-Forwarded-Encrypted: i=1; AJvYcCUOuGqyh+BSrYB2UBRdwvAvn+ljZCW1ulfPrwdNzE/y3+yPdDy7n/VG/yvB+ggIsOSWWL4=@vger.kernel.org, AJvYcCVU7Nnyv5U3xrZ4xPu9tU+Bk1GNFgOyYtdP5DQ4m1z4yJNFQyB1wZzn58t4NFi5s9mSuuP4vJiD@vger.kernel.org, AJvYcCVVbWZyviAntnZ1tXN9VRnbm107V1L+R5eUD2H2bHF8pGSuyVMsUieEP9a4vJNPaHs2eyGNlCLH27wraZfAuFWf@vger.kernel.org, AJvYcCW5ng9v/1FqypJAzgSE3vSv7TIu3RCWXUudf0c4hw4nfKc46XF5173f/dVhwoZD75IaTwAJOFXcK+p84iwp@vger.kernel.org, AJvYcCXoB4bGvkJU4ybgeTBWmKt/uft7uWKZaYSGHtrPUcUzFwDVlR9OIudSI/OzykWk5Hcqus8k6Si4//fi@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7tPqrKcIySbxWtVHxeo/uu98D/krU/OeZxP4CX+oLBio/MZO
	fBo8WRiYuimYZrPKDxu5r7YNv3xRUCeCr/N2CS7dLYILzuEvrzE=
X-Gm-Gg: ASbGncsbs1jk0SYbdd7O7K2WkHNzbWf/2iYtVjpMiHx6J+/tBd2cPuTUWPKvrdhMwN9
	ha6yQ8lDh10k6exJ81AO9TTAMatbcF1VF7TMkHivBKvX2N6/NvBLW03uslgZcRieAwoKd6Eh0vj
	3W1hnQrYrBmrc+zwUi1r5PINrCp9S3RGqHW8pof6p+9U7ecYyU5MnPTUcJfGCAoRTWGHS4mCFMh
	W9DACtMueCQiVLVNnyvzWmTizcanxmlQeL1G3PRQRtz9xVvh6c9B6ap
X-Google-Smtp-Source: AGHT+IFENMHtBxMqOYbLnyZklK8TxKhy57F1FhvRUtYUInQIrUA9rU8ymAx4xYOehq+j+0FGzA2uug==
X-Received: by 2002:a17:903:41d1:b0:217:8557:5246 with SMTP id d9443c01a7336-219e6f4979amr721019265ad.55.1736268612929;
        Tue, 07 Jan 2025 08:50:12 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7d83sm314319215ad.226.2025.01.07.08.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:50:12 -0800 (PST)
Date: Tue, 7 Jan 2025 08:50:11 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
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
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v4 1/4] xsk: Add launch time hardware offload
 support to XDP Tx metadata
Message-ID: <Z31bQ6xEkyQvbutN@mini-arch>
References: <20250106135606.9704-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106135606.9704-1-yoong.siang.song@intel.com>

On 01/06, Song Yoong Siang wrote:
> Extend the XDP Tx metadata framework so that user can requests launch time
> hardware offload, where the Ethernet device will schedule the packet for
> transmission at a pre-determined time called launch time. The value of
> launch time is communicated from user space to Ethernet driver via
> launch_time field of struct xsk_tx_metadata.
> 
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>  Documentation/netlink/specs/netdev.yaml      |  4 ++
>  Documentation/networking/xsk-tx-metadata.rst | 64 ++++++++++++++++++++
>  include/net/xdp_sock.h                       | 10 +++
>  include/net/xdp_sock_drv.h                   |  1 +
>  include/uapi/linux/if_xdp.h                  | 10 +++
>  include/uapi/linux/netdev.h                  |  3 +
>  net/core/netdev-genl.c                       |  2 +
>  net/xdp/xsk.c                                |  3 +
>  tools/include/uapi/linux/if_xdp.h            | 10 +++
>  tools/include/uapi/linux/netdev.h            |  3 +
>  10 files changed, 110 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index cbb544bd6c84..e59c8a14f7d1 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -70,6 +70,10 @@ definitions:
>          name: tx-checksum
>          doc:
>            L3 checksum HW offload is supported by the driver.
> +      -
> +        name: tx-launch-time
> +        doc:
> +          Launch time HW offload is supported by the driver.
>    -
>      name: queue-type
>      type: enum
> diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
> index e76b0cfc32f7..3cec089747ce 100644
> --- a/Documentation/networking/xsk-tx-metadata.rst
> +++ b/Documentation/networking/xsk-tx-metadata.rst
> @@ -50,6 +50,10 @@ The flags field enables the particular offload:
>    checksum. ``csum_start`` specifies byte offset of where the checksumming
>    should start and ``csum_offset`` specifies byte offset where the
>    device should store the computed checksum.
> +- ``XDP_TXMD_FLAGS_LAUNCH_TIME``: requests the device to schedule the
> +  packet for transmission at a pre-determined time called launch time. The
> +  value of launch time is indicated by ``launch_time`` field of
> +  ``union xsk_tx_metadata``.
>  
>  Besides the flags above, in order to trigger the offloads, the first
>  packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
> @@ -65,6 +69,65 @@ In this case, when running in ``XDK_COPY`` mode, the TX checksum
>  is calculated on the CPU. Do not enable this option in production because
>  it will negatively affect performance.
>  
> +Launch Time
> +===========
> +
> +The value of the requested launch time should be based on the device's PTP
> +Hardware Clock (PHC) to ensure accuracy. AF_XDP takes a different data path
> +compared to the ETF queuing discipline, which organizes packets and delays
> +their transmission. Instead, AF_XDP immediately hands off the packets to
> +the device driver without rearranging their order or holding them prior to
> +transmission. In scenarios where the launch time offload feature is
> +disabled, the device driver is expected to disregard the launch time
> +request. For correct interpretation and meaningful operation, the launch
> +time should never be set to a value larger than the farthest programmable
> +time in the future (the horizon). Different devices have different hardware
> +limitations on the launch time offload feature.
> +
> +stmmac driver
> +-------------
> +
> +For stmmac, TSO and launch time (TBS) features are mutually exclusive for
> +each individual Tx Queue. By default, the driver configures Tx Queue 0 to
> +support TSO and the rest of the Tx Queues to support TBS. The launch time
> +hardware offload feature can be enabled or disabled by using the tc-etf
> +command to call the driver's ndo_setup_tc() callback.
> +
> +The value of the launch time that is programmed in the Enhanced Normal
> +Transmit Descriptors is a 32-bit value, where the most significant 8 bits
> +represent the time in seconds and the remaining 24 bits represent the time
> +in 256 ns increments. The programmed launch time is compared against the
> +PTP time (bits[39:8]) and rolls over after 256 seconds. Therefore, the
> +horizon of the launch time for dwmac4 and dwxlgmac2 is 128 seconds in the
> +future.
> +
> +The stmmac driver maintains FIFO behavior and does not perform packet
> +reordering. This means that a packet with a launch time request will block
> +other packets in the same Tx Queue until it is transmitted.
> +
> +igc driver
> +----------
> +
> +For igc, all four Tx Queues support the launch time feature. The launch
> +time hardware offload feature can be enabled or disabled by using the
> +tc-etf command to call the driver's ndo_setup_tc() callback. When entering
> +TSN mode, the igc driver will reset the device and create a default Qbv
> +schedule with a 1-second cycle time, with all Tx Queues open at all times.
> +
> +The value of the launch time that is programmed in the Advanced Transmit
> +Context Descriptor is a relative offset to the starting time of the Qbv
> +transmission window of the queue. The Frst flag of the descriptor can be
> +set to schedule the packet for the next Qbv cycle. Therefore, the horizon
> +of the launch time for i225 and i226 is the ending time of the next cycle
> +of the Qbv transmission window of the queue. For example, when the Qbv
> +cycle time is set to 1 second, the horizon of the launch time ranges
> +from 1 second to 2 seconds, depending on where the Qbv cycle is currently
> +running.
> +
> +The igc driver maintains FIFO behavior and does not perform packet
> +reordering. This means that a packet with a launch time request will block
> +other packets in the same Tx Queue until it is transmitted.

Since two devices we initially support are using FIFO mode, should we more
explicitly target this case? Maybe even call netdev features
tx-launch-time-fifo? In the future, if/when we get support timing-wheel-like
queues, we can export another tx-launch-time-wheel?

It seems important for the userspace to know which mode it's running.
In a fifo mode, it might make sense to allocate separate queues
for scheduling things far into the future/etc.

Thoughts? No code changes required, just more explicitly state the
expectations.

