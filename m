Return-Path: <linux-kselftest+bounces-41993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670EB8C7E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E46B161562
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A93016F0;
	Sat, 20 Sep 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEVeZNi2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719733016E4;
	Sat, 20 Sep 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370879; cv=none; b=K8Dj0TyoxS+w0o6xVjp8k0oAYH0eY7v0Fkwpb11qVacCs/DDq/LxDwJG0+0Ufs5+cvHqZUjrczQ8UdRU4xrbQruATzCMit33VU2Kc77hToZyRFFmievZlnv5pNYjuIrYfOfXQ+umn8NG9/VjIzqWf/LT/LcDKKacEzug5kHxZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370879; c=relaxed/simple;
	bh=qmhQ5jk5ZWkgG/yTVBSLdGX0usuVMNTWO7fxuZpsTFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXmmrSkjBjdbIVfRODC8W59dtFMX8lyhOzfv9u/BCz6/wJtpeTOfWbYfWiQNmnM/cUecH/nkFs4OUUVDY/3wF/WVU27loX2m8RvCvX2rSc/y8KHkvFSpm/cRhx1GNlwZOczGYI8+t4kzVMoaAbgCsmwX47+ODekwRgGgc28siqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEVeZNi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617DAC4CEF7;
	Sat, 20 Sep 2025 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758370878;
	bh=qmhQ5jk5ZWkgG/yTVBSLdGX0usuVMNTWO7fxuZpsTFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GEVeZNi2JksDR00LDpwzC2h5oVY0lpNPAaGhEBrRJrHZDZsUcJIy1VgPOgvrMftcO
	 aWWICBF83QhqmZb2P40ZyLwkXc6tZFnWf99v+2yp0oTwbRq06IK2xaG036qVuxNuHB
	 9Fn1LhuTgvhahiEvS5rEEL28WTQ/nxSqIxmy4v39kdcbOX8Lhnk/kO17jhoDOOdkqx
	 o3Im4e8gNBJ2FXYOwk/l/6nNpY2IgI/gO9P0v1yKq78TlQaeAjkJA+RO+8tkFKEBl7
	 /f6ocoMuNj+amQ8ykVIM40rUIHz7NzVNREdw3h3d9IUSjXcJtS3Nmv3l5WsWkBYwnq
	 eTlJnLSL6SfOQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 20 Sep 2025 14:20:27 +0200
Subject: [PATCH RFC bpf-next 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-xdp-meta-rxcksum-v1-1-35e76a8a84e7@kernel.org>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
In-Reply-To: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
checksum will be use by devices capable of exposing receive checksum
result via bpf_xdp_metadata_rx_checksum().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -61,6 +61,11 @@ definitions:
         doc: |
           Device is capable of exposing receive packet VLAN tag via
           bpf_xdp_metadata_rx_vlan_tag().
+      -
+        name: checksum
+        doc: |
+          Device is capable of exposing receive checksum result via
+          bpf_xdp_metadata_rx_checksum().
   -
     type: flags
     name: xsk-flags

-- 
2.51.0


