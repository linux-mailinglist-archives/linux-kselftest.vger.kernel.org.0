Return-Path: <linux-kselftest+bounces-40138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B449B39209
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 04:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936C7464669
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8079A27C158;
	Thu, 28 Aug 2025 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="iHKgQEsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2C280A5E;
	Thu, 28 Aug 2025 02:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349960; cv=none; b=s74lbm5jH0rOo+wYkY5b7RqId963NvseISyagDiBFhhJ8YJF6Fbvrv5CGBsV/GSbNMU4p1OcTIeKmWTiNeVlWjmSJCLF2XgjTSEb+MATj5ze8J5mkL7ONXYWIgFRphTyXtVATTmwaPBIYvLdvqp5JGGTD2yNRKPpG6bHsBBWUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349960; c=relaxed/simple;
	bh=5gs41ZCC4d6DGtyICS++oNVNudnBDahs+aRZExwrWp8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dtyKb+qEkFYJiVjDSEIJfE5C7iWMFT4SBUM5pFIf8NdMpwebpR/1wy43eS8mZhmgvdw45DWgOBFQlHg1UXkrpneht/bvC88Cfo4gsGdnumwUfG3gdj3SnA58XRHK+yU/lGwRX5U3ljmpC4FLljeXb7CC/WGGo25jU3XECpz/DkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=iHKgQEsD; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756349955;
	bh=ktoQ0Z4pHUomM4rTJgPBIVs37Sa+v1lzPTgiPz0znA8=;
	h=From:To:Cc:Subject:Date;
	b=iHKgQEsDerldHfjc0yol/l7IC/pF9yA5ngY7cMx6+GGl+2AXh9oEsFFplT6NJAyF9
	 6vfmiiHKChFSdFjx5QR4JHKSKNUu9bv4CuIGS8G0kZhvP4R2EvSHpks5w6dPqCbtEp
	 AIiMwm2Njm7EKTmTi0Gv4mmVTPoZBHIRoMSuPtX8=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id D3AAC8AB; Thu, 28 Aug 2025 10:52:58 +0800
X-QQ-mid: xmsmtpt1756349578txd2xn0jh
Message-ID: <tencent_A23159E297D62A89AF24A3EA881106A44208@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAqe7hFlzhMx+sRMiuTr8xqpPQTKZIl1/5iC0lKaVxEcET4fW0Dk
	 1AvdVCdHh0G+NynAg1cg+DSgQNpWbZ78HhK/ces1Tm6zOZmAekxYFp56reE0xozUjHMkZTAWHaXO
	 kjC/MENVgb0sSqnn045pTSRj+2hYqO2gyraW+z6Mzc/6qu8L4iIqoihAgVMp4zC7juZY9smjsoSD
	 /ZbQGwWFrXRJ+ZlsxQKfcMuQaqqiOsOgZbqG2o/akZYE9iVe+dncam6ZrUTptm0BxKYdS5pZgMeb
	 MpovU6q06Pu/lZzT/gtrdYDTOsrTZH3qy6fNOk7273txV6a11Zg7TGSmcVnXFONyEBmR7wslEXYt
	 mM0ZRU+0zjgopLr3bR6sAK/SGjWmhuKATaj+RstT/mwAuTbBzvKSFQx83JaXRTIuTDEw3ikqQQnL
	 eSqLOnzRkbjZd1GqdNMMHbXq23V67cW0wBq9j5YrEcX5DN6q43NHLynT04JLI9iPLoK+wjfKqn6e
	 w39h8eR0q0HqNkGvqPVThJ6h3uvSuJ3FvB9W6fBMrakKZGVH5FIECjYq+d63eV4ey9x8Eax+lyB3
	 vs82OBvvalBSzpyXhwNaQ5pkVa2nbypHnr8xfkURX5YiKXcaMc/2aTJSWgeCmKh9wKi81k7zuVLU
	 rGuZi0RXl1B2tcKg0SdzxXAnk5ed2zkdGxyZFsddBwfE2AnahzJ0saW9p++SzTadTZ+hYyEKEV/e
	 T0VXY4ECzgb2F/z4HKUGRJRG0txxMWWZX5xbl3DuvYvNXIycwbIxFCjKRALSAXlAR07+MongIe6O
	 4xkQysIU4DaeSWRgCHau7vZGswo3zWKw3PQl1BsITEeteYawXOoFOoL4L9iaNEbEdYZaSdRe/D9L
	 AgvE0m7VzBzWK5O4bL+DroOJBe5T3Ws+ynGo57gr2ulZj0otsK2MfNQdm+PGsHH7+a1qc3E80O1L
	 dtwc3HeFtwW6Fwyefgiqq+zO/0pXu1IjOhQe7IO2GVOK62rQHPHmmrsn4xiQJU3fcP6TqCo5gQg+
	 kPzYnSkgIe4rTvF6VLaVBC7kuYPS/HqsxN7HcXLs8NBZjNKHik6nja6gNm9y4=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
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
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [bpf-next v2 0/2] bpf/helpers: Fix bpf_strnstr len error
Date: Thu, 28 Aug 2025 10:52:01 +0800
X-OQ-MSGID: <cover.1756348926.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Fix bpf_strnstr() wrong 'len' parameter, bpf_strnstr("open", "open", 4)
should return 0 instead of -ENOENT.

Rong Tao (2):
  bpf/helpers: bpf_strnstr: Exact match length
  selftests/bpf: Add tests for bpf_strnstr

 kernel/bpf/helpers.c                                      | 4 +++-
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

---
v2: Follow Andrii Nakryiko's advise, fix the 'wrong fix';
v1: https://lore.kernel.org/lkml/tencent_65E5988AD52BEC280D22964189505CD6ED06@qq.com/
-- 
2.51.0


