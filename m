Return-Path: <linux-kselftest+bounces-26721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16821A37051
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 20:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573253B0B2B
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 19:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D461F37D8;
	Sat, 15 Feb 2025 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOSb0Y5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF451624D3;
	Sat, 15 Feb 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739646272; cv=none; b=cbxYigX5iULanDMi+VNTLAJg4CJh9lP/xZHkRL0Gt/VJP/EWjvb9neHBvL8N+pjgjjYlSVv8Y3Z1J7X5nBry6i7PEkRvq2PQqCScvPNWKo578SJWuU53HcaDAp9U1HFqzQSl0P8nG+4F60joaB3k4rxoDUwcvUkq0RWl+MiU1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739646272; c=relaxed/simple;
	bh=Df2b8aVgJjFNJGQ3bD+jOZ3m5M4kbFV5KsneEFnbz1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+gBBUtfdQ8MrKOfJZ+eIzWUhUgdlEc1M8VZevXxJytlxkUYDM16zknFq0FoD0S1ZTH9BqXitA3haaL8D+0/V3GtvQzgY2Bzkybwa7mr6dTuxjiaPKyyrVfF5+fHANtXmKk8vBo4ZbNIFF7IRhYe5tr0G5vF3Ul3sq5RPcQdONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOSb0Y5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D038CC4CEDF;
	Sat, 15 Feb 2025 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739646271;
	bh=Df2b8aVgJjFNJGQ3bD+jOZ3m5M4kbFV5KsneEFnbz1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HOSb0Y5rS2c+iF55klymj6B0z0P3nkofcNiCgsMP5plndlLE+6Ux2rzZK9kiCXW0A
	 8Xv9r5UvZhELq5KpOx3B3v+yWB5mCSwHcqK5aJtn5i9hYLs9s/hOsJ+NSMtxlU6Qzl
	 SAmAb3QN87QQ4fNEWxSaL0jt3Bc2P5Unl9V11YdJZrVbuWkOxjDpNQv8aOVjjCDGEk
	 BRrau+nibXXPqTvtcM4xYrX6rwfHPAQUZu1Sr7G6uCXWbwx3ZmngcvJqZYiyb0h0rq
	 WO1T/S5i1kzxfiA2YYuU0zPyax6bsKZ3H6dUECjmFG8VpVNYCdjH2uRurDUOBQw58t
	 V3Llh8KYjzaug==
Date: Sat, 15 Feb 2025 11:04:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Florian Bezdeka
 <florian.bezdeka@siemens.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, Magnus
 Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Joe Damato
 <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, Daniel
 Jurgens <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Faizal Rahim
 <faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Bouska Zdenek
 <zdenek.bouska@siemens.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v10 1/5] xsk: Add launch time hardware offload
 support to XDP Tx metadata
Message-ID: <20250215110428.68f25c5e@kernel.org>
In-Reply-To: <20250215110159.0c1888ae@kernel.org>
References: <20250207021943.814768-1-yoong.siang.song@intel.com>
	<20250207021943.814768-2-yoong.siang.song@intel.com>
	<20250215110159.0c1888ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 11:01:59 -0800 Jakub Kicinski wrote:
> On Fri,  7 Feb 2025 10:19:39 +0800 Song Yoong Siang wrote:
> > Extend the XDP Tx metadata framework so that user can requests launch time
> > hardware offload, where the Ethernet device will schedule the packet for
> > transmission at a pre-determined time called launch time. The value of
> > launch time is communicated from user space to Ethernet driver via
> > launch_time field of struct xsk_tx_metadata.  
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Sorry, I take that back, you haven't regenerated the code after
renaming the flag:

diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index fc0aa971d276..b97ff8bbb0c6 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -59,13 +59,13 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
- * @NETDEV_XSK_FLAGS_LAUNCH_TIME: Launch Time HW offload is supported by the
- *   driver.
+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is supported
+ *   by the driver.
  */
 enum netdev_xsk_flags {
        NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
        NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
-       NETDEV_XSK_FLAGS_LAUNCH_TIME = 4,
+       NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
 };
 
 enum netdev_queue_type {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index fc0aa971d276..b97ff8bbb0c6 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -59,13 +59,13 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
- * @NETDEV_XSK_FLAGS_LAUNCH_TIME: Launch Time HW offload is supported by the
- *   driver.
+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is supported
+ *   by the driver.
  */
 enum netdev_xsk_flags {
        NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
        NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
-       NETDEV_XSK_FLAGS_LAUNCH_TIME = 4,
+       NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
 };
 
 enum netdev_queue_type {

