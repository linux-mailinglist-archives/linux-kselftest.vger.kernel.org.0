Return-Path: <linux-kselftest+bounces-34761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9139AD60F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799CC3AB194
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2616A1C8632;
	Wed, 11 Jun 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cm1llxK3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15C2441A0
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676621; cv=none; b=mYCVlNq1DDj1o7hxWN/2IBe2ffuUofI/JaryrCtL/wna2kTgvlAQ0TyStfDsqKFsG+GIiEKmKpwmkD7foFfdtXSf3PqeJ5wdMY/nIOJ/lf8zIqa2eCS4WN7qmZZuattKdG3uFkA6lfQFtDcM1HdIuPyFrgwJI4RKBNmW1Kg70co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676621; c=relaxed/simple;
	bh=b4VA2RGdpApRaSDkLmIRrxzmznFdKL/sDPXrbgY9dp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j4QYeJPk+S31B2lkeeDneAHFp0nuaio14o9b+PlSFyXw9ujpjiWsbcbTEk76CD2dXsTweeVlrPf4ASo90v0Kpe1YRWEwqLJnoyZGz3nAgmr8lM8mGUQISRbqHZn3RYDobegl7kF6N+XsrDIWXIMR6zpxwVSuxw1qW613MpuaU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cm1llxK3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2fa1a84568so128094a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676619; x=1750281419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zir2Z2BYD9TVMhA71zOuRqts4XDUJGWDctYBYtUWNnI=;
        b=cm1llxK3nvYST9jiAVqkkidlRCmrAXeSYqwy5PPrNaWKYbh+8JqYpvcGN3lgsTf/Wc
         ozOIWGOnoc3hfQTF0B6lXe3+itn5k30LD3dLFa4w4HfC5LGDLbWXOVRs+IXdnlE1Z98Q
         mJ6ntD92WvBTZ/ut1U/0QlZcolXoKaZa8e641SZ+cebYF2uEvRFg7j2FaC4+JXDpMKbp
         HBqnC5tMXLi16unbvBxg/+CzaOhV09X5+Or0itEx7ufRKimATNBtoHrmhh7F+viWJSz8
         FrO+aSNBa/wQGiIXEyLzUIFtM3fVraFwQk2o3P65osGSVPAnfM3WFKUENx0utPSoZV5j
         flYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676619; x=1750281419;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zir2Z2BYD9TVMhA71zOuRqts4XDUJGWDctYBYtUWNnI=;
        b=kt4tg4s3qfdZf5Na8QgFVGF9cV+jX/MAYfbJokN0SkjmYBU9qHo939jBFsDU8Eb69V
         h2QeYepeuPu7InEBaSUpQQ0JIbD3WSohRkUMWcTmy5FGZWTpiZYHVeDbjDl/LRZIfEw+
         IiEbKiW/EzzVfQqJld/yX8TqYZy4A0nTxJ7WlFgXQhcueT5XDCkd6BPA7uukR/1WGJxp
         GDUGW7nZhQRF+lyeNGCabS1HvFfT5ISsfkGRfyn1i7/b8qQgtayIBcSMhnVQXIvdIcmI
         TEzw07Y2c5A1hYdevklXxWzLpqch+fS9irYVfZl5MGtx4CCXPQfIcOizhZM1auJ2ZrwR
         L5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXxhqHsMYPB0QnHkQMQ2sFNJbvJvQAOLkQj+GR4/z6KQY7tZ/o8kIylWn42c1PDiNDZXZkOMwn00KsaLJHSfts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhSoyWwsNDhz0kcerrw6GmO5r32JE4C0BLmRwzpyT3nxHHxMR
	9d5wC195ni+VESgqEdyhnfYyVzwe7QcrydxZ4njiKk/JPizf2Nh6ii8CR+LxutYVd8n1d2iWVz6
	r0/cfhGU3ng==
X-Google-Smtp-Source: AGHT+IFEdzwI0hLX7jOjgrsvuEtZ1pf59QC5BkheGfaBuI5bKPz0+MMRvkX5eBM8K7fT56stpLxx97K0L1P1
X-Received: from pjbof7.prod.google.com ([2002:a17:90b:39c7:b0:312:e5dd:9248])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5866:b0:311:b5ac:6f7d
 with SMTP id 98e67ed59e1d1-313bfd90b31mr1285824a91.6.1749676618837; Wed, 11
 Jun 2025 14:16:58 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:29 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <ee22d844512a828dc5285a93676699d1aca0e0ed.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 02/10] KVM: x86: Adjust locking order in move_enc_context_from
From: Ryan Afranji <afranji@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: sagis@google.com, bp@alien8.de, chao.p.peng@linux.intel.com, 
	dave.hansen@linux.intel.com, dmatlack@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de, 
	zhi.wang.linux@gmail.com, ackerleytng@google.com, andrew.jones@linux.dev, 
	david@redhat.com, hpa@zytor.com, kirill.shutemov@linux.intel.com, 
	linux-kselftest@vger.kernel.org, tabba@google.com, vannapurve@google.com, 
	yan.y.zhao@intel.com, rick.p.edgecombe@intel.com, 
	Ryan Afranji <afranji@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Previously, the order for acquiring the locks required for the migration
function move_enc_context_from() was: 1) memslot lock 2) vCPU lock. This
can trigger a deadlock warning because a vCPU IOCTL modifying memslots
will acquire the locks in reverse order: 1) vCPU lock 2) memslot lock.

This patch adjusts move_enc_context_from() to match vCPU IOCTL=E2=80=99s lo=
cking
order to prevent deadlock warnings.

Signed-off-by: Ryan Afranji <afranji@google.com>
---
 arch/x86/kvm/svm/sev.c | 13 +------------
 arch/x86/kvm/x86.c     | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 402543994b0b..380d5951f8dd 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1961,26 +1961,15 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, s=
truct kvm *source_kvm)
 		charged =3D true;
 	}
=20
-	ret =3D kvm_lock_all_vcpus(kvm);
-	if (ret)
-		goto out_dst_cgroup;
-	ret =3D kvm_lock_all_vcpus(source_kvm);
-	if (ret)
-		goto out_dst_vcpu;
-
 	ret =3D sev_check_source_vcpus(kvm, source_kvm);
 	if (ret)
-		goto out_source_vcpu;
+		goto out_dst_cgroup;
=20
 	sev_migrate_from(kvm, source_kvm);
 	kvm_vm_dead(source_kvm);
 	cg_cleanup_sev =3D src_sev;
 	ret =3D 0;
=20
-out_source_vcpu:
-	kvm_unlock_all_vcpus(source_kvm);
-out_dst_vcpu:
-	kvm_unlock_all_vcpus(kvm);
 out_dst_cgroup:
 	/* Operates on the source on success, on the destination on failure.  */
 	if (charged)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b1672379a16b..c28fa28a8e42 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6743,10 +6743,18 @@ static int kvm_vm_move_enc_context_from(struct kvm =
*kvm, unsigned int source_fd)
 	if (r)
 		goto out_mark_migration_done;
=20
-	r =3D kvm_lock_vm_memslots(kvm, source_kvm);
+	r =3D kvm_lock_all_vcpus(kvm);
 	if (r)
 		goto out_unlock;
=20
+	r =3D kvm_lock_all_vcpus(source_kvm);
+	if (r)
+		goto out_unlock_vcpus;
+
+	r =3D kvm_lock_vm_memslots(kvm, source_kvm);
+	if (r)
+		goto out_unlock_source_vcpus;
+
 	r =3D kvm_move_memory_ctxt_from(kvm, source_kvm);
 	if (r)
 		goto out_unlock_memslots;
@@ -6762,6 +6770,10 @@ static int kvm_vm_move_enc_context_from(struct kvm *=
kvm, unsigned int source_fd)
=20
 out_unlock_memslots:
 	kvm_unlock_vm_memslots(kvm, source_kvm);
+out_unlock_source_vcpus:
+	kvm_unlock_all_vcpus(source_kvm);
+out_unlock_vcpus:
+	kvm_unlock_all_vcpus(kvm);
 out_unlock:
 	kvm_unlock_two_vms(kvm, source_kvm);
 out_mark_migration_done:
--=20
2.50.0.rc1.591.g9c95f17f64-goog


