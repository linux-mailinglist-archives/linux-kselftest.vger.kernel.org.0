Return-Path: <linux-kselftest+bounces-29939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B31A75E34
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 05:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98382188A4F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 03:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06614F121;
	Mon, 31 Mar 2025 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uJmALa1e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F712147C9B
	for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743391621; cv=none; b=qHc7ZuutLDlbixURUIu4SBuFPbzwmGqSdomsmrZyxCq+poJYTSno05uSFxmQx0baVggOBIIZp3FKBFfCLQYEl5H0yQqkBKcbOXCuO7dtoEr3jYCwURal15X6Hcy8brhu76A8URsFdDvJcsYcCMWh+x+r6qQVCcXyu0UTj4NuOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743391621; c=relaxed/simple;
	bh=tzuN8IjR1mEQGCTPep5anJyLSvsgqCrlXY3ll7fvh9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyQKWR2wLTyJyzXD06juex2HutvihiI8b8Yy4EhowmuGaVxRajEB7Ewt4SN+EMpqLxSI3uhEKZMi4FOdWv3Jt86t9Q//P5RjUWdJsWFtG57ghqvDNN5hNHl2sDrw849aItnUCmZ6S5t3GD6kOegOmUJhWbWmdA5jX0f1CbzJBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uJmALa1e; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743391617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzy0awE5ZZK9+iAkW/TYDxKTJBg1F7RhmxVg91DnCY8=;
	b=uJmALa1eJZxrmO1eEIbmgH/nIByoTi1Wfo3TOKYgeSv4pMi2PU5PJnbaJgqKQaACn6NkJT
	nlrv86obx9TU0+nRdPRA74iWiXTYBGIho9cgiamTg4XbzaZuPz7XpFVX8yidqQoeNx2C8/
	fFZAKtLbXQwbSTGSP7Y9Af1tjiScbFI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Jordan Rome <linux@jordanrome.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf, xdp: clean head/meta when expanding it
Date: Mon, 31 Mar 2025 11:23:44 +0800
Message-ID: <20250331032354.75808-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250331032354.75808-1-jiayuan.chen@linux.dev>
References: <20250331032354.75808-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The device allocates an skb, it additionally allocates a prepad size
(usually equal to NET_SKB_PAD or XDP_PACKET_HEADROOM) but leaves it
uninitialized.

The bpf_xdp_adjust_head function moves skb->data forward, which allows
users to access data belonging to other programs, posing a security risk.

Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/uapi/linux/bpf.h       | 8 +++++---
 net/core/filter.c              | 5 ++++-
 tools/include/uapi/linux/bpf.h | 6 ++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index defa5bb881f4..be01a848cbbf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2760,8 +2760,9 @@ union bpf_attr {
  *
  * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
  * 	Description
- * 		Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
- * 		it is possible to use a negative value for *delta*. This helper
+ *		Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
+ *		it is possible to use a negative value for *delta*. If *delta*
+ *		is negative, the new header will be memset to zero. This helper
  * 		can be used to prepare the packet for pushing or popping
  * 		headers.
  *
@@ -2989,7 +2990,8 @@ union bpf_attr {
  * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
  * 	Description
  * 		Adjust the address pointed by *xdp_md*\ **->data_meta** by
- * 		*delta* (which can be positive or negative). Note that this
+ *		*delta* (which can be positive or negative). If *delta* is
+ *		negative, the new meta will be memset to zero. Note that this
  * 		operation modifies the address stored in *xdp_md*\ **->data**,
  * 		so the latter must be loaded only after the helper has been
  * 		called.
diff --git a/net/core/filter.c b/net/core/filter.c
index 46ae8eb7a03c..5f01d373b719 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3947,6 +3947,8 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
 	if (metalen)
 		memmove(xdp->data_meta + offset,
 			xdp->data_meta, metalen);
+	if (offset < 0)
+		memset(data, 0, -offset);
 	xdp->data_meta += offset;
 	xdp->data = data;
 
@@ -4239,7 +4241,8 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
 		return -EINVAL;
 	if (unlikely(xdp_metalen_invalid(metalen)))
 		return -EACCES;
-
+	if (offset < 0)
+		memset(meta, 0, -offset);
 	xdp->data_meta = meta;
 
 	return 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index defa5bb881f4..7b1871f2eccf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2761,7 +2761,8 @@ union bpf_attr {
  * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
  * 	Description
  * 		Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
- * 		it is possible to use a negative value for *delta*. This helper
+ *		it is possible to use a negative value for *delta*. If *delta*
+ *		is negative, the new header will be memset to zero. This helper
  * 		can be used to prepare the packet for pushing or popping
  * 		headers.
  *
@@ -2989,7 +2990,8 @@ union bpf_attr {
  * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
  * 	Description
  * 		Adjust the address pointed by *xdp_md*\ **->data_meta** by
- * 		*delta* (which can be positive or negative). Note that this
+ *		*delta* (which can be positive or negative). If *delta* is
+ *		negative, the new meta will be memset to zero. Note that this
  * 		operation modifies the address stored in *xdp_md*\ **->data**,
  * 		so the latter must be loaded only after the helper has been
  * 		called.
-- 
2.47.1


