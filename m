Return-Path: <linux-kselftest+bounces-25033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8534A1AA9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 20:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77CF3A9094
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 19:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5D187859;
	Thu, 23 Jan 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3uU9gih"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2BC7E105;
	Thu, 23 Jan 2025 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661687; cv=none; b=j5vjrlFX6mzsou8yboTIj3d6xwlW39iY3AaAr+ZruC9D7eyZUGG8S5rPTsb79HZ6BCdZJQjVEBY3eLcOcGja6PGH3t8YtHbDl6c99MMugwKUCJSdtcqwdCjuH/ito3iBc9XOXDP0aDLfMdYRDB6/Nr6h4V1KMXSfD6pXSx7CeCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661687; c=relaxed/simple;
	bh=R5eq8Cex/cCFfzROIu49amxr7ud3e0QBK/r543OCYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3kvCnvCgYSyK2dyMAmuneVlCApWrmb69PXg0WKFdww/pwJeIuxAlk9P5g0sEGSsh90UdCsEcNk2V3R6w2Aqb/gT0jbtdz9P7j6BRXRW2xIslabY8CwnTFSaEXsdhZusYa7E0AmW7z/XldCwGTXNeYQVtCunnOIZn7dbMD62+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3uU9gih; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b662090so25985575ad.1;
        Thu, 23 Jan 2025 11:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661684; x=1738266484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ehvXM/x2Xpjmareg8hVceTaEqRxIeAlXfZcNgyZJpQ=;
        b=M3uU9gihOkq2WGY33qULcvbyH64vshgGIOQ9h+Lgcul6lZQhAm6tT9VTnMnzjmhTL8
         6rmCA3T2CECeDjYqeHBPF30zV3rGx17qg0nNJ29CJgav0RaVGuWyhMskBF1Kt/DbEuo7
         NP56etciJy1GyMuEKzFkepIirak+v2t09zGfziqZzMT7sJWOEjGHhqLIqWnNp6lFNpUI
         vFGrpOBJw38VdL1Q6bnfRHcLlhxGdwQC77eyQj2gl5c+bX/xt+sl8MK4SAh3rEorDUQe
         y+LY7IPj0o5NBIta/NDN1Pdq1BAfbPAeJPicw7LV2P6KK89OCnh1k60bUTBPHECkkOEs
         tkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661684; x=1738266484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ehvXM/x2Xpjmareg8hVceTaEqRxIeAlXfZcNgyZJpQ=;
        b=t9U9TJ6x/nFy8Ghgs2TXrHkmIM3QzGyRdlJDrxSQB0axGefFHIAaR2DPYHRhMoCxhV
         gZdrSH/wwmNmWFzbUXCowmz8g9YRA22DVLoziOwFuZVkDEKAuf5EZn7ld+mAFmZfu93d
         BtreyMLrSS5RafFUP1QLD1DNvXSBd8FiAjFCo0Wgl2+18P2IPWrlWMqreYub7yLLiYaN
         +C0l82pmRBJrMisVM8pl0E8ucKU6wSGcUpxtdoArWjDy/UMZuqY6cvJxNpwesLtgFLU0
         6h5mS8pzhqZ4fyXb10KOkG+EnAKHn9K55tl2xQtEvENwDv4Nto+PFSHJvWNLZ43ucmzX
         I+GA==
X-Forwarded-Encrypted: i=1; AJvYcCUuSzdkzlUXMQfOCqm4QVvOp8fVNPpk+/16CkNzILthynwAWuM4/Den6YHe3dT1jP+84XteHUuPEUeNloFL@vger.kernel.org, AJvYcCWHBoN+BgANKpT87PHcE1smjc2ScAzzCe6ELVpBjum1z8Dc9fUI/0n8eAx0kLqEaFtbcI1ejsTf@vger.kernel.org, AJvYcCWrREr79o8+qe7iZ7bwdqHybeW8H8OJQRhhEBQdlbTBwOY8Bytj2dr36ncXjnlDHfW0lgY=@vger.kernel.org, AJvYcCXClui1Cc2HqwnMztfl/quoIlP/BbnYsSl9I1iJcCVTH0CgBTzv5/7+nxbE8fqblwzoYzsKFB/LwwT5@vger.kernel.org, AJvYcCXIiGMPmsOFF4Wo1Dv8KvF/MoJN5fdLMms+73Dy8Aj3jExKYO30qKM6ADMZii16QMN/TUtT+eAOz1Lftqdl84Mk@vger.kernel.org
X-Gm-Message-State: AOJu0YziWZxpviZALT4FA5nS839Gsc8sN32OHuD0ZH8wpKH1x7ozlL7/
	VuGrnFej+atf7jP5oqVa8e8CGOV2l3ww26A3pDdDW++NfE0CUtQ=
X-Gm-Gg: ASbGncs46vO94i6a4I27JqMB1JoXemHsef93h81Fke6OV+jz6FoeqhxyVow7MvPsmvq
	ER4+aSdEcRYCFZaffKP4W37bxgRrGEUeSiJe0pGDBdThMHp5CsVS12o4i7LVZRK5lnc5I5cOrIy
	2zUNtEBlhwad8QtfSvteErh1T+4Ks+F+FCriuDx2CArMm0yXBS9ufCPBlPo0pyyRRx1GVW729jj
	kflhHsyvS1vM8TqloVonlPgl/GoGcN8QqWypKR8pwG/fAp3eFPgxWm98L/I9/ktRo3wzJVvw+7I
	TOrQ
X-Google-Smtp-Source: AGHT+IHN0sZtZXkNpILip1vz+eYUU1Y/MTgN8GKmFzFYwee95EZNDldTyC5bmSvcCfRBqUDdtCAgnw==
X-Received: by 2002:a17:902:e548:b0:216:60a3:b3fd with SMTP id d9443c01a7336-21c351d345amr370312355ad.3.1737661684548;
        Thu, 23 Jan 2025 11:48:04 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea2430sm2880515ad.65.2025.01.23.11.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:48:04 -0800 (PST)
Date: Thu, 23 Jan 2025 11:48:03 -0800
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
Subject: Re: [PATCH bpf-next v6 2/4] selftests/bpf: Add launch time request
 to xdp_hw_metadata
Message-ID: <Z5Kc8wufjrsXMCW9@mini-arch>
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
 <20250116155350.555374-3-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116155350.555374-3-yoong.siang.song@intel.com>

On 01/16, Song Yoong Siang wrote:
> Add launch time hardware offload request to xdp_hw_metadata. Users can
> configure the delta of launch time relative to HW RX-time using the "-l"
> argument. By default, the delta is set to 0 ns, which means the launch time
> is disabled. By setting the delta to a non-zero value, the launch time
> hardware offload feature will be enabled and requested. Additionally, users
> can configure the Tx Queue to be enabled with the launch time hardware
> offload using the "-L" argument. By default, Tx Queue 0 will be used.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Forgot to add:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

