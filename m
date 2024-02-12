Return-Path: <linux-kselftest+bounces-4508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B517E8512AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 12:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEE5283ADF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 11:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BF53A1AB;
	Mon, 12 Feb 2024 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dgS4ZctN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8339FF2;
	Mon, 12 Feb 2024 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738739; cv=none; b=iXhEv3+Ag+1qV/UCQ74veUmg5/afhHbPuNZ/8aVGTXtZmFaoRAAFNrLXjXKwNkp9JrcGJxTDPhuLf295AE4YKX2d+0wgvuNqnrFEdEB1CkYHPq8FJnqfctXzexdvUwcy6orudb8TRKB06qjaD//Q/PmeKltYK/yz/J357E6gS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738739; c=relaxed/simple;
	bh=R5Siob6CCLBGrDAD5GuIEDn6D5MDxIAanPSGgDwFZ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0Ysdg2xK8hQOpCUSVvSwXV/kxNb5EtILB7zINgB2O7itGYjxvqlMMr5SmB8ynRNspZLykP4VYiTXk1oYoZ4UNFIe0BQ7uQ26+pbfBplaNTDJVF7gTfkhWWFIKlADFI04qrBzPxmUD33d9YnbqIkbT/u4boQ+ReSmLN/bE54DYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dgS4ZctN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CBROGu023509;
	Mon, 12 Feb 2024 11:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=S7o9Z6pwsmsdDFKwNn54jtm3khMYkc+v9Z3xJfxFfHs=;
 b=dgS4ZctNcMwpKjt6vLY6n/XHCmYfAcl6YGl3zPppOusOtLnZyShx9xnlBlwyuBH5pkOu
 t3Krd8eiubOMSgUE1MBhuPNYFGXLWO+HLApKpnjLu7Tl/qlcZjptTRZ/bwri9WfpKbvO
 bbxunnH0rtV4A/I09JSCpN5tFzJSkwkNdeSDsBLbhKiSV9VIvJN8hbeQRdfAaHcWe7lm
 tick52tBzvY/11FfuZErJSjm/DsaDYxLzVGq7+W2rS+fVdY6p6wvVC1EI/m8CvslspHE
 Rp84+H4CYtPAJ9EoUvoXRvuKs3q267eQd65r9hgyhNWNH6KAr+Xa1H60hK1gQEGkaCqR 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jferhjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:52:14 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CBmnXV023786;
	Mon, 12 Feb 2024 11:52:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jferhj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:52:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CBVDuk009680;
	Mon, 12 Feb 2024 11:52:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkg09n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:52:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CBq7sd12321422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 11:52:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D085220040;
	Mon, 12 Feb 2024 11:52:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F9F020043;
	Mon, 12 Feb 2024 11:52:07 +0000 (GMT)
Received: from osiris (unknown [9.171.5.16])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 11:52:06 +0000 (GMT)
Date: Mon, 12 Feb 2024 12:52:05 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: s390: load guest access registers in MEM_OP
 ioctl
Message-ID: <20240212115205.9156-C-hca@linux.ibm.com>
References: <20240209204539.4150550-1-farman@linux.ibm.com>
 <20240209204539.4150550-2-farman@linux.ibm.com>
 <20240212102130.9156-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212102130.9156-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2L_VlrAdg7PrRTjoy4XmK8pxi8ZAcn5z
X-Proofpoint-GUID: Fesulud__aAsKbL5xcIrXceyoXtnPpGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=540 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402120090

On Mon, Feb 12, 2024 at 11:21:30AM +0100, Heiko Carstens wrote:
> Or maybe a TIF flag with different semantics: "guest save area does not
> reflect current state - which is within registers".

Something like the below; untested of course. But I guess there must be
some arch specific vcpu flags, which can be used to achieve the same?

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index a674c7d25da5..b9ff8b125fb8 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -69,6 +69,7 @@ void arch_setup_new_exec(void);
 #define TIF_PATCH_PENDING	5	/* pending live patching update */
 #define TIF_PGSTE		6	/* New mm's will use 4K page tables */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
+#define TIF_KVM_ACRS		8	/* access registers contain guest content */
 #define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
 #define TIF_PER_TRAP		10	/* Need to handle PER trap on exit to usermode */
 
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 5bfcc50c1a68..b0ef242d2371 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -391,7 +391,8 @@ static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, u8 ar,
 	if (ar >= NUM_ACRS)
 		return -EINVAL;
 
-	save_access_regs(vcpu->run->s.regs.acrs);
+	if (test_thread_flag(TIF_KVM_ACRS))
+		save_access_regs(vcpu->run->s.regs.acrs);
 	alet.val = vcpu->run->s.regs.acrs[ar];
 
 	if (ar == 0 || alet.val == 0) {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ea63ac769889..3ee0913639d5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4951,6 +4951,7 @@ static void sync_regs(struct kvm_vcpu *vcpu)
 	}
 	save_access_regs(vcpu->arch.host_acrs);
 	restore_access_regs(vcpu->run->s.regs.acrs);
+	set_thread_flag(TIF_KVM_ACRS);
 	/* save host (userspace) fprs/vrs */
 	save_fpu_regs();
 	vcpu->arch.host_fpregs.fpc = current->thread.fpu.fpc;
@@ -5020,6 +5021,7 @@ static void store_regs(struct kvm_vcpu *vcpu)
 	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
 	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
 	save_access_regs(vcpu->run->s.regs.acrs);
+	clear_thread_flag(TIF_KVM_ACRS);
 	restore_access_regs(vcpu->arch.host_acrs);
 	/* Save guest register state */
 	save_fpu_regs();

