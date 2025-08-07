Return-Path: <linux-kselftest+bounces-38457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A5B1D5D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4D33B1250
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 10:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD352269B01;
	Thu,  7 Aug 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p5/6mjoN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725326561E;
	Thu,  7 Aug 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562606; cv=none; b=CvODFIQyN4dyBDaK5bin3eLMQYRTOrHDAN1KfROFrP/63sTNzi3IWWsBCOyrbLevVX7ppYyqRHSBv1wrTMSvOl7tlaVWyqKE9mYqZZflR1CAamFC8YcXQeRSxgiaA+5VUtR7/L/73FVN7u/4lob0Sal0K3yfEgzkjVnnv8cfa6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562606; c=relaxed/simple;
	bh=He4oXwRkGQwwnMKuvE1JNOy0L9t+AV80B+PiKJMBwW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCmXUFZrcFXov5/U1NwwB7JpHPMgu1hG+Q0W32UKa8fa0IowIUehv2M8d7EQdBILBYECzlBQDcr+popKw3HaoLX5YfT1fhpqL78kVDg2uwA4y4IS3Lwa7Cif8OtbB/iRNH9veLcOGnXTIH2XZ2xR583qZYSCl4+9JyDtC0x4Hd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p5/6mjoN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57722E0s029284;
	Thu, 7 Aug 2025 10:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jY0FVL
	TdDSDoJ57bi4wKXnVk8rdd8QZwfL9IBgn8/B8=; b=p5/6mjoNxyJJimXhlH2t4f
	0+XDNx/S/zFf1LpP+yeGQlqOh4aSxf+JtJAiK5ek3mCDxtqqIfuvsdhU8DISUdiL
	aqZke5cEAQodX/o/JXSwxrMaXmZn57VlctOsclkm+JRZY93yM2q6dSYQXfiGaKAq
	MY0N1r8/v+Ty/DID6VrNOdfl+tk3dfDUh4IslqAfKWfb1gUIZ7zTfPcteSzjm94v
	ly/JfK9+C+0SBB95pcv+vxfFFr7jOGQLkkm1QYdmUt5Um1df+kOUbpv4GLmwZRp+
	hmovVogdMGd2qc1o8GipDMyUHhWIta2pIQCLM2KYm/41RsXYNyV99ZHh+8pYdd4Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq611mbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 10:29:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577ARCK0015633;
	Thu, 7 Aug 2025 10:29:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq611mbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 10:29:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5779etoQ020603;
	Thu, 7 Aug 2025 10:29:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwn03yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 10:29:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577ATMWe56492312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 10:29:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED6332004D;
	Thu,  7 Aug 2025 10:29:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6142F20065;
	Thu,  7 Aug 2025 10:29:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.219.153])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Aug 2025 10:29:17 +0000 (GMT)
Date: Thu, 7 Aug 2025 15:59:15 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, hbathini@linux.ibm.com,
        sachinpb@linux.ibm.com, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org
Subject: Re: [bpf-next 1/6] bpf,powerpc: Introduce
 bpf_jit_emit_probe_mem_store() to emit store instructions
Message-ID: <aJR/+4cl8NzhIsQU@linux.ibm.com>
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
 <20250805062747.3479221-2-skb99@linux.ibm.com>
 <e65548d0-14aa-4b9c-8051-7c91c5dffd1f@csgroup.eu>
 <8cfa1cb2-57bf-4984-a64e-53c82440e87f@linux.ibm.com>
 <e8c39250-e9a0-4075-92b2-ffa2344a9212@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8c39250-e9a0-4075-92b2-ffa2344a9212@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DSzCux4_h6B7ySns_xeM7ItLouIEWGKF
X-Proofpoint-ORIG-GUID: G9LxTEJixdQw1il1gwmEI6kL9RZFksiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA3OCBTYWx0ZWRfX01cQkLNHoPfi
 ZfC6/ckNr1UxBAgVL6Fw/O49ir83bbqyIA3XqqwkmGlhIo+SsZCIgEeSmk8SzwinvJpTIjpB/9+
 ftto1aotSMbt2sWhN2rPBm458Yf9FFGeDqn/KtdcwJLMT7QKnKrbObmFefX2OAR0qzG2OsuHY4E
 V3WNhtNyEWdV7oG19StT/2Kw9Wb6Sen7JiPT/QDxI6O1Du0NgPnYYc2XKa4H0VzymomRwiHdxgc
 g4AzQJI+cz2yiAtRGxawibp/FMy3O+f7WngcO1MVVTZd32UpDTX6KMrzYOIbPgA7V2U1qegE4zT
 BbxEbHlKon/WGNLLUXauom4ixETEr84qW+cnFx4+5ZkheeEqTGVxDYuVwCSRK5IlaA635P7YULx
 RZVqwluSzZPYW+h7n/DOHemcwkpBVsGrATprg9qkjGQNxBvDyhXLPGtMwNBvUcW7UOOgchEF
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=68948008 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=Oh2cFVv5AAAA:8 a=VnNF1IyMAAAA:8 a=Eszfrv2eY0fpnUJKUzwA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070078

On Wed, Aug 06, 2025 at 08:59:59AM +0200, Christophe Leroy wrote:
> 
> 
> Le 05/08/2025 à 13:59, Venkat Rao Bagalkote a écrit :
> > 
> > On 05/08/25 1:04 pm, Christophe Leroy wrote:
> > > 
> > > 
> > > Le 05/08/2025 à 08:27, Saket Kumar Bhaskar a écrit :
> > > > bpf_jit_emit_probe_mem_store() is introduced to emit instructions for
> > > > storing memory values depending on the size (byte, halfword,
> > > > word, doubleword).
> > > 
> > > Build break with this patch
> > > 
> > >   CC      arch/powerpc/net/bpf_jit_comp64.o
> > > arch/powerpc/net/bpf_jit_comp64.c:395:12: error:
> > > 'bpf_jit_emit_probe_mem_store' defined but not used [-Werror=unused-
> > > function]
> > >  static int bpf_jit_emit_probe_mem_store(struct codegen_context
> > > *ctx, u32 src_reg, s16 off,
> > >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > > make[4]: *** [scripts/Makefile.build:287: arch/powerpc/net/
> > > bpf_jit_comp64.o] Error 1
> > > 
> > I tried this on top of bpf-next, and for me build passed.
> 
> Build of _this_ patch (alone) passed ?
> 
> This patch defines a static function but doesn't use it, so the build must
> breaks because of that, unless you have set CONFIG_PPC_DISABLE_WERROR.
> 
> Following patch starts using this function so then the build doesn't break
> anymore. But until next patch is applied the build doesn't work. Both
> patches have to be squashed together in order to not break bisectability of
> the kernel.
> 
> Christophe
> 
Got it Chris, will squash both the patches together in v2.
> > 
> > Note: I applied https://eur01.safelinks.protection.outlook.com/?
> > url=https%3A%2F%2Flore.kernel.org%2Fbpf%2F20250717202935.29018-2- puranjay%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C0468473019834e07ef2b08ddd4179b9c%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638899920058624267%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=iZLg9NUWxtH3vO1STI8wRYLzwvhohd2KKTAGYDe3WnM%3D&reserved=0
> > before applying current patch.
> > 
> > gcc version 14.2.1 20250110
> > 
> > uname -r: 6.16.0-gf2844c7fdb07
> > 
> > bpf-next repo: https://eur01.safelinks.protection.outlook.com/? url=https%3A%2F%2Fkernel.googlesource.com%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbpf%2Fbpf-next&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C0468473019834e07ef2b08ddd4179b9c%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638899920058644309%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=OrMauttrzPbaFYhzKdkH5l%2FltISc95MwitnUC7YLhJQ%3D&reserved=0
> > 
> > HEAD:
> > 
> > commit f3af62b6cee8af9f07012051874af2d2a451f0e5 (origin/master, origin/
> > HEAD)
> > Author: Tao Chen <chen.dylane@linux.dev>
> > Date:   Wed Jul 23 22:44:42 2025 +0800
> > 
> >      bpftool: Add bash completion for token argument
> > 
> > 
> > Build Success logs:
> > 
> >    TEST-OBJ [test_progs-cpuv4] xdp_vlan.test.o
> >    TEST-OBJ [test_progs-cpuv4] xdpwall.test.o
> >    TEST-OBJ [test_progs-cpuv4] xfrm_info.test.o
> >    BINARY   bench
> >    BINARY   test_maps
> >    BINARY   test_progs
> >    BINARY   test_progs-no_alu32
> >    BINARY   test_progs-cpuv4
> > 
> > 
> > Regards,
> > 
> > Venkat.
> > 
> > > 
> > > > 
> > > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > > ---
> > > >   arch/powerpc/net/bpf_jit_comp64.c | 30 ++++++++++++++++++++++++++++++
> > > >   1 file changed, 30 insertions(+)
> > > > 
> > > > diff --git a/arch/powerpc/net/bpf_jit_comp64.c
> > > > b/arch/powerpc/net/ bpf_jit_comp64.c
> > > > index 025524378443..489de21fe3d6 100644
> > > > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > > > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > > > @@ -409,6 +409,36 @@ asm (
> > > >   "        blr                ;"
> > > >   );
> > > >   +static int bpf_jit_emit_probe_mem_store(struct
> > > > codegen_context *ctx, u32 src_reg, s16 off,
> > > > +                    u32 code, u32 *image)
> > > > +{
> > > > +    u32 tmp1_reg = bpf_to_ppc(TMP_REG_1);
> > > > +    u32 tmp2_reg = bpf_to_ppc(TMP_REG_2);
> > > > +
> > > > +    switch (BPF_SIZE(code)) {
> > > > +    case BPF_B:
> > > > +        EMIT(PPC_RAW_STB(src_reg, tmp1_reg, off));
> > > > +        break;
> > > > +    case BPF_H:
> > > > +        EMIT(PPC_RAW_STH(src_reg, tmp1_reg, off));
> > > > +        break;
> > > > +    case BPF_W:
> > > > +        EMIT(PPC_RAW_STW(src_reg, tmp1_reg, off));
> > > > +        break;
> > > > +    case BPF_DW:
> > > > +        if (off % 4) {
> > > > +            EMIT(PPC_RAW_LI(tmp2_reg, off));
> > > > +            EMIT(PPC_RAW_STDX(src_reg, tmp1_reg, tmp2_reg));
> > > > +        } else {
> > > > +            EMIT(PPC_RAW_STD(src_reg, tmp1_reg, off));
> > > > +        }
> > > > +        break;
> > > > +    default:
> > > > +        return -EINVAL;
> > > > +    }
> > > > +    return 0;
> > > > +}
> > > > +
> > > >   static int emit_atomic_ld_st(const struct bpf_insn insn,
> > > > struct codegen_context *ctx, u32 *image)
> > > >   {
> > > >       u32 code = insn.code;
> > > 
> 

