Return-Path: <linux-kselftest+bounces-1967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA909813D7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 23:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69321C21B9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A24C6E2CB;
	Thu, 14 Dec 2023 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="V1GB+wpO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sT5D85BD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19D6D1DD;
	Thu, 14 Dec 2023 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 761BC3200B5A;
	Thu, 14 Dec 2023 17:49:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 14 Dec 2023 17:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1702594156; x=1702680556; bh=ZFh7mAohRzEfC8EAB2/qm
	p1+GaJriUVMYQQUQ3IIsw8=; b=V1GB+wpOoDak5vL+2MbB2FmZc2tbIaaW7zhcy
	3D2sgArYuLnDisYAvIKjdqO8M5yit/3qQVC5y7itqyibMcEChryljNurDW7mczhq
	9dKX3MyQOwh3jggs6Q2mw2ugVyHw3a0tGuN31vvH0oRFkVmZpkBoFbemiRpXUosF
	XNVwt2OQaHHHN3NNR+VwWGnCbrBWvXv22Yyz6nH8rxa1UOCT0nrt107wOQCPOQHl
	oovqK/b97wdrHa884Dsvs/G6nSNClRonWz3HCAdRhTOa7ZvB63m87KkLN9XTzUDy
	NPDyml4KsWv4x1nH9O1QfmDxYBsC/bKVXEMEiZkaFzHozEYuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702594156; x=1702680556; bh=ZFh7mAohRzEfC8EAB2/qmp1+GaJr
	iUVMYQQUQ3IIsw8=; b=sT5D85BD/BhB2O7l+q58viyr2LKs/tpShV89mY3IDL+H
	ky3ebZThMzW9NXAbxT4fCHAynMZkPGceemU6fgOd0s5A7rcTM2FSlrhrUZmYnbN3
	JfgO7d/PRdw98mARIb/6Nc+GK1I2ObS8ihfSVaCIU1GEJvXWkZSAoJnvZrYigclW
	QoJJCaBTGhDHueU0Qq1nwAnVgv95+tfKm5bMvy50yXP9cpx6u26DO6PUa+KEoJ1V
	eVkAf0kD2RwzWimOibwovMXRlsb1ltiJA6r8iJgMO6GKkm2Pt9Y4oeTNdXsjDxEA
	6/BD/Zu8JICuxGVVRrVXWD76vK2i5YQUREo0p7/C0w==
X-ME-Sender: <xms:bIZ7ZVq4220B-391OcaC7cml5qO-TcAFnrftrGbmvgavPloHgy6_ew>
    <xme:bIZ7ZXp2HHV96fk0cJSWrL9tIKIIxw3svPDJleJvNigIJXx_JWrAr0y64Wf_iEODx
    hIdLti2r_xAC_pMww>
X-ME-Received: <xmr:bIZ7ZSNmaGuoT9WCu3RB2lXr5G3hCjPr1CwjC117u-6IIr5-Uf9nzaXIwYiUs3CmogxLD_4FGjB7VznDCO3XioWAMLWN0sEHo4znnFCHxMgdcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieekhedugeetvedutdfhie
    elhfejgfeuueeuffevveehgefgueefjeefuedukeefnecuffhomhgrihhnpehivghtfhdr
    ohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:bIZ7ZQ5bXk4GWLzXp0FsE-3g75SystpD6tXrSWTi623H7KHgcCUFkA>
    <xmx:bIZ7ZU4dJ3XftXR2w8NCeSfWzdYtOdYiy4PCPpNjaxBVmlrzgl-GXQ>
    <xmx:bIZ7ZYgqyi7c-pwa1D8Kg2AHPW6Gf9wPmCkT3SM8z8wFESWQU3rMIw>
    <xmx:bIZ7ZVFbGEIv2sDHf6OfDKprhn5KFRb9zkeMkI5m8c2AvJX_AQeLLA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 17:49:15 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
Cc: devel@linux-ipsec.org
Subject: [PATCH bpf-next v6 0/5] Add bpf_xdp_get_xfrm_state() kfunc
Date: Thu, 14 Dec 2023 15:49:01 -0700
Message-ID: <cover.1702593901.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds two kfunc helpers, bpf_xdp_get_xfrm_state() and
bpf_xdp_xfrm_state_release() that wrap xfrm_state_lookup() and
xfrm_state_put(). The intent is to support software RSS (via XDP) for
the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
on (hopefully) reproducible AWS testbeds indicate that single tunnel
pcpu ipsec can reach line rate on 100G ENA nics.

Note this patchset only tests/shows generic xfrm_state access. The
"secret sauce" (if you can really even call it that) involves accessing
a soon-to-be-upstreamed pcpu_num field in xfrm_state. Early example is
available here [1].

[0]: https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/03/
[1]: https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357d6ce2863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406

Changes from v5:
* Improve kfunc doc comments
* Remove extraneous replay-window setting on selftest reverse path
* Squash two kfunc commits into one
* Rebase to bpf-next to pick up bitfield write patches
* Remove testing of opts.error in selftest prog

Changes from v4:
* Fixup commit message for selftest
* Set opts->error -ENOENT for !x
* Revert single file xfrm + bpf

Changes from v3:
* Place all xfrm bpf integrations in xfrm_bpf.c
* Avoid using nval as a temporary
* Rebase to bpf-next
* Remove extraneous __failure_unpriv annotation for verifier tests

Changes from v2:
* Fix/simplify BPF_CORE_WRITE_BITFIELD() algorithm
* Added verifier tests for bitfield writes
* Fix state leakage across test_tunnel subtests

Changes from v1:
* Move xfrm tunnel tests to test_progs
* Fix writing to opts->error when opts is invalid
* Use __bpf_kfunc_start_defs()
* Remove unused vxlanhdr definition
* Add and use BPF_CORE_WRITE_BITFIELD() macro
* Make series bisect clean

Changes from RFCv2:
* Rebased to ipsec-next
* Fix netns leak

Changes from RFCv1:
* Add Antony's commit tags
* Add KF_ACQUIRE and KF_RELEASE semantics

Daniel Xu (5):
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: selftests: test_tunnel: Setup fresh topology for each subtest
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: Move xfrm tunnel test to test_progs
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 +
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 134 +++++++++++++++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 162 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++++-------
 tools/testing/selftests/bpf/test_tunnel.sh    |  92 ----------
 8 files changed, 384 insertions(+), 155 deletions(-)
 create mode 100644 net/xfrm/xfrm_state_bpf.c

-- 
2.42.1


