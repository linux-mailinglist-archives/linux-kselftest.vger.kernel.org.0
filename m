Return-Path: <linux-kselftest+bounces-16374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3DD96041C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC3D1F23060
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31426192599;
	Tue, 27 Aug 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XL66B2rp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66F13D53F;
	Tue, 27 Aug 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746428; cv=none; b=KzGN8+nWjDJ/ZkCzQ3+eDkJootZ52a4lqY39ViBP6xGGYnpRrlQzrxeT+E4Iz/jApgCjLKK6GCuIbkR4WLXBUaiBr1eBlRtM+HWLOqu+t/8KpYo75n3ZcAyMYcQ+2zHZ29nJtt0aKucn+0km0hA8+EhnAkUh5/5cqmc+MOnnPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746428; c=relaxed/simple;
	bh=5QfsJTyIY32W/wA54Kf19YGCYgreDzccpzOQVRfQiBg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gZsIVMZODYEmDtVtYnAE3SfAo4R5TCkkX41OvBiWCSiYUG2oErUGCy6iUKanPx9J7VyADtzk0ylvHdBhUbPOWbBW6CBBUv4F+PMMqk9Lr8+sYF52U0Z1cwZ5pW9ntptVi02Bob2UZ0mSAsN4J1pXlGOEajWBpxqOsu1yj8LE2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XL66B2rp; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724746410; bh=8n5ghoJPbarAekh4wde579rn7yevYYmJTRo6ruyL1Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XL66B2rpYAoXOQgBvTZSru+0n5s0HG5x2pePu26M0FW2MJ2NdrHJE0gZRPeTU8teG
	 5W2vGbHQj181cfColmNECtx0Z6a/vhLrR4FSG3XrbhGqsY6YnpIH3bZalI18YBTAQh
	 115BEp8ZYAl+QfZ+r0GgQA74VdSLdo2nZRL8z4+s=
Received: from cyy-pc.lan ([240e:379:224b:5f00:16b6:fb41:2849:da9d])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 1CBA7234; Tue, 27 Aug 2024 16:07:11 +0800
X-QQ-mid: xmsmtpt1724746043tpuyub02x
Message-ID: <tencent_387731262004AB31874F45504D7BC2F11705@qq.com>
X-QQ-XMAILINFO: Mm0mzSig0p2pUXSd5oAdHOeLQuZOsj9T7ASgnZ5wcRxByrv6k5m3cjVaM+S36v
	 ObZgtDSbamsYnPtEBSOlXZKQRjS8noCBT3NEQRJ+2TekpQ4oGBhTOGUA0pMOw4fI0KfU7jzuRXes
	 EwY9yvV6Ul7qGPbA8Zu4ItVl9xCEKZZRTXNyITp8r0Q3v9ZYEmsF147TgEWtLYzjsa4mh+MXGOs6
	 8L7221oUUm3V+SPvCbxN4IUq0qREB2ZNVL+doHpA8pfdV7wT3JVZBOSxE9E/dv+Tu2yNK54uTOmU
	 R2AZChfkZmJ5IlOLGUgXMIN+d4F5TlxB9FoL+7FxGxT+WteO/Zb+BGnRobqAh1Mw5MgiwFFD1IJg
	 lwoey8gPI6s8vUZj0bPLnim52y/KnmhC6e/FUdp9TowYjx7DQ5S8dmKncs2P0e0YXUjwX+wXGNHw
	 2RfBo3OgwsmGi0Fw+Z5LU7KMQimdI3bNCFW7pWAYLO2hpET5bAgdPHfrtT7KfWBXG93x5rIk3DTn
	 4t16hU3EItrmZzhnxJTqi+wG6VdvtcPXj96tnCZESumhktY8Tqt/fS9l6yb+P4Nxi5oEkuTM4az3
	 DZxeyrz4wrFe4xP54pvYDpI/JFL1+JbvVUzFp6q81jWyHjw1eyLQw97IDY0/M4QvRBviT7PQUYR7
	 lQOF0Qpd9GrGABrnldzPpqabv3+QtMp1cxZYE8IxeuNL9CHQ/U9vAA8WANbW4rLp/fOfiuz/eS8/
	 X+KWZKR4b9h+vie1+s4J0Js35bJakp1FD2LP7gZJJtDnqvsbwFjGvZHMxw2EYpvbxuSgvWKqiJb1
	 1DQRkPKmo4xhemOIKLsBI7nRcV70OLEl8mjS94ow3ktxsMNYKAC4BbXCQnUJzoM+PLerEinpBdvq
	 H5/Mt+yD5xWNdnGZ97s4pIKtChSHiUjZfULRWEet6En6OXd584ynt85kmiNKPEQb8fFbLxXPJyyM
	 0mwoPc7fkuoXN7Pc3A4rUx12ZwjOR2tl2oRBlAGxIFCGf88EHGcikdcHWdR5SOp0SIfF6ccmHaG2
	 pfHkj9KExg6h4t1AS5dougdm6aSdA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <shuah@kernel.org>,
	Levi Zim <rsworktech@outlook.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v3 3/3] Documentation: riscv: correct sv57 kernel behavior
Date: Tue, 27 Aug 2024 16:07:07 +0800
X-OQ-MSGID: <20240827080707.3788836-3-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <tencent_108260B43689E30AAE5D0C7C085AA31ADF06@qq.com>
References: <tencent_108260B43689E30AAE5D0C7C085AA31ADF06@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original documentation treated the hint address on mmap as the upper
bound, since we have already removed this behavior, this document should
be updated. Most of the content is copied from the corresponding feature
in x86_64 with some modifications to align with the current kernel's
behavior on RISC-V.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/arch/riscv/vm-layout.rst | 43 +++++++++++++++++---------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
index 077b968dcc81..826d0a3f4cbf 100644
--- a/Documentation/arch/riscv/vm-layout.rst
+++ b/Documentation/arch/riscv/vm-layout.rst
@@ -136,17 +136,32 @@ RISC-V Linux Kernel SV57
   __________________|____________|__________________|_________|____________________________________________________________
 
 
-Userspace VAs
---------------------
-To maintain compatibility with software that relies on the VA space with a
-maximum of 48 bits the kernel will, by default, return virtual addresses to
-userspace from a 48-bit range (sv48). This default behavior is achieved by
-passing 0 into the hint address parameter of mmap. On CPUs with an address space
-smaller than sv48, the CPU maximum supported address space will be the default.
-
-Software can "opt-in" to receiving VAs from another VA space by providing
-a hint address to mmap. When a hint address is passed to mmap, the returned
-address will never use more bits than the hint address. For example, if a hint
-address of `1 << 40` is passed to mmap, a valid returned address will never use
-bits 41 through 63. If no mappable addresses are available in that range, mmap
-will return `MAP_FAILED`.
+User-space and large virtual address space
+==========================================
+On RISC-V, Sv57 paging enables 56-bit userspace virtual address space. Not all
+user space is ready to handle wide addresses. It's known that at least some JIT
+compilers use higher bits in pointers to encode their information. It collides
+with valid pointers with Sv57 paging and leads to crashes.
+
+To mitigate this, we are not going to allocate virtual address space above
+47-bit by default.
+
+But userspace can ask for allocation from full address space by specifying hint
+address (with or without MAP_FIXED) above 47-bits, or hint address + size above
+47-bits with MAP_FIXED.
+
+If hint address set above 47-bit, but MAP_FIXED is not specified, we try to look
+for unmapped area by specified address. If it's already occupied, we look for
+unmapped area in *full* address space, rather than from 47-bit window.
+
+A high hint address would only affect the allocation in question, but not any
+future mmap()s.
+
+Specifying high hint address without MAP_FIXED on older kernel or on machine
+without Sv57 paging support is safe. The hint will be treated as the upper bound
+of the address space to search, but this was removed in the future version of
+kernels. On machine without Sv57 paging support, the kernel will fall back to
+allocation from the supported address space.
+
+This approach helps to easily make application's memory allocator aware about
+large address space without manually tracking allocated virtual address space.
-- 
2.45.2


