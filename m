Return-Path: <linux-kselftest+bounces-12106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31B90BFFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 02:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D170D1F21B55
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 00:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FF479F2;
	Tue, 18 Jun 2024 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFna5DPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93261E894
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668879; cv=none; b=WUeK/xEfsqm9VXxhy71Uvun/ZVUwbszLmD7ZJ5oqA0wX2da+87K8JuVbeIfC3UaMv4RMv0P/kODQXD4g+PqICk62xqLfClWY7wRdkc3toaKSlc5yXvUDbi5b8mxgjfJIIu/z4/Mw8l1odikQ503fbnBAw1y9uQ6yNeUcijul838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668879; c=relaxed/simple;
	bh=e/6DXxfSmYa3PcUmKtpMGJIGbMO7nKFl8LeS2R3DEGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Su2ZzimMgMyvn84EVB7Rhkk0Ej8w9WKUMMQHRuhGuBp5Mb76nUuz6FkCGy2nLu/rdsH0k8MuCM1RvcqGZS3TTCOiPqKl0Ccy2VoZimRAzc79nyzg6FuF/hMOe7IXlSNjQGweKy2AQTj4TTLsSoYofnlHdld0RYQ+4PadDZqRH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JFna5DPC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44056f72257so154041cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 17:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718668877; x=1719273677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYJUxDNTjiWQv0Dn1lpauSNYmPE3A/rHJsXpHH3eFP8=;
        b=JFna5DPCvoT7i+915WaN+fSX0q2JBqZdzU5JXtgNOSUO4aJnm8ba6fmkpVp7WKSvNV
         0hnE9mFv7OCh2GQTbEJu4fVYv9Ni6/oWR0BUaw+Y076rvDkdbhE7fSOev2Tth30fPnRu
         CGWVsQ53lCAuaLSJtkguUJMVl6A5ZqEqax+K2jsvLAoSL9t9cN1t1uZQQggQoPBicnt3
         q1x7b/JwDho/zxGah/9ZEE4rUR9GjYqTrlK799pYXySFrFPSSbIfjiA5O6gTrHyG2TqK
         OgGCnEQJMTpxD4dQty4eS38rxWY5Gk8WzV5PiCKvuXXEMQpsdhQmoFKfkWrDxMglihJN
         ZncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718668877; x=1719273677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYJUxDNTjiWQv0Dn1lpauSNYmPE3A/rHJsXpHH3eFP8=;
        b=krI2hpzsvTBPruzKxYChQuvqu+fTcNlolfnuaht/TVdFypS+Sk+JrHl9Gil1WxFGxA
         RJnrfWoBGyK/7YztToyhqiISrqp1h7FINixzudalM8f6XmsKruLhTTIlLatB9GwMnsfF
         K+/YFwcSyLGjIZahhFY6YhCY0kp79FEwSLWDxDkDrQH2LkPmp/PCewU/zswbZwX81MkW
         Euvpz+Kxiyk7fNh/skprN9C5sePxiNA/PIW5tS+Na4cta5SJuDSzhe/oqbub3g1mjCqq
         jEvkNvkb6fIwP7taBcLV4jK5eY4k6uH7vEaSriTLl8W5dc7duzDzj4EDEoNsx3mLadCp
         yT3A==
X-Forwarded-Encrypted: i=1; AJvYcCUgScKJSDmiBrjRX/B8KdLTWqHTjbDN78kK0C08gDPY6ahC3HeVGw8EgRCNnmrmga6BPzXjceUoJyx5CV4lS43GG5IO5kxdJo6iBb9RZPV6
X-Gm-Message-State: AOJu0Yw5cyHcfxqHmMLxlZhjLHQHsy99aIO9BoXn8e8361bLr07mNZGT
	zgESaARrmT6CPgy2occ8fFtTTKFB25sIIqW4iYZNEnWecMjOfCzO30/2orBOa70/Dcbv3AhR4N9
	dE66/+3Lz1VxWKhh4pvDaAeLjv5CJJxMnBRhD
X-Google-Smtp-Source: AGHT+IHL1VOVBEEYIsDFmk7aYzMKo8+wU/oagSvanZsj7KqgaXrEPucAwYquOmDWm0/JC3eqHJ8+6hozxzfwg6DHtB4=
X-Received: by 2002:a05:622a:4e96:b0:444:a09e:c60e with SMTP id
 d75a77b69052e-444a09ed740mr85851cf.24.1718668876650; Mon, 17 Jun 2024
 17:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613082345.132336-1-shahuang@redhat.com> <20240613082345.132336-3-shahuang@redhat.com>
In-Reply-To: <20240613082345.132336-3-shahuang@redhat.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 17 Jun 2024 17:01:02 -0700
Message-ID: <CAJHc60y67Be=XcJuy__2RN43WyN6YgukSAb0=T6TGwYHw+YpHg@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] KVM: selftests: aarch64: Introduce pmu_event_filter_test
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shaoqin


On Thu, Jun 13, 2024 at 1:28=E2=80=AFAM Shaoqin Huang <shahuang@redhat.com>=
 wrote:

> +static void prepare_expected_pmce(struct kvm_pmu_event_filter *filter)
> +{
> +       struct pmu_common_event_ids pmce_mask =3D { ~0, ~0 };
> +       bool first_filter =3D true;
> +       int i;
> +
> +       while (filter && filter->nevents !=3D 0) {
Do you also want to add a check to ensure we aren't running over
FILTER_NR (I'd expect a compiler warning/error though)?

> +               if (first_filter) {
> +                       if (filter->action =3D=3D KVM_PMU_EVENT_ALLOW)
> +                               memset(&pmce_mask, 0, sizeof(pmce_mask));
> +                       first_filter =3D false;
> +               }
nit: Probably we can make the 'first_filter' part a little cleaner by
checking this outside the loop.

if (filter && filter->action =3D=3D KVM_PMU_EVENT_ALLOW)
        memset(&pmce_mask, 0, sizeof(pmce_mask));

while (filter && filter->nevents !=3D 0) {
    ...
}

> +static struct test_desc tests[] =3D {
> +       {
> +               .name =3D "without_filter",
> +               .filter =3D {
> +                       { 0 }
> +               },
> +       },
> +       {
> +               .name =3D "member_allow_filter",
> +               .filter =3D {
> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 0),
In terms of readability, do you think it's better to use
KVM_PMU_EVENT_{ALLOW|DENY}, instead of 0 and 1?

Or, if that's coming out to be too long, may be create another wrapper
over DEFINE_FILTER, and simply use that in the array:

#define EVENT_ALLOW(event) DEFINE_FILTER(event, KVM_PMU_EVENT_ALLOW)
#define EVENT_DENY(event) DEFINE_FILTER(event, KVM_PMU_EVENT_DENY)

.filter =3D {
    EVENT_ALLOW(ARMV8_PMUV3_PERFCTR_SW_INCR),

> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_INST_RETIRED, 0=
),
> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_BR_RETIRED, 0),
> +                       { 0 },
> +               },
> +       },

> +       {
> +               .name =3D "cancel_filter",
> +               .filter =3D {
> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 0),
> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 1),
> +               },
Since the initial filter map depends on the event being allowed or
denied, do you think another "cancel_filter" case to first deny and
then allow would also be better?

> +       },
> +       {
> +               .name =3D "multiple_filter",
> +               .filter =3D {
> +                       __DEFINE_FILTER(0x0, 0x10, 0),
> +                       __DEFINE_FILTER(0x6, 0x3, 1),
> +               },
> +       },
> +       { 0 }
> +};
> +
> +static void run_tests(void)
> +{
> +       struct test_desc *t;
> +
> +       for (t =3D &tests[0]; t->name; t++)
> +               run_test(t);
> +}
> +
> +int used_pmu_events[] =3D {
nit: static int used_pmu_events[] =3D {

Thank you.
Raghavendra


> +       ARMV8_PMUV3_PERFCTR_BR_RETIRED,
> +       ARMV8_PMUV3_PERFCTR_INST_RETIRED,
> +       ARMV8_PMUV3_PERFCTR_CHAIN,
> +};
> +
> +static bool kvm_pmu_support_events(void)
> +{
> +       struct pmu_common_event_ids used_pmce =3D { 0, 0 };
> +
> +       create_vpmu_vm(guest_get_pmceid);
> +
> +       memset(&max_pmce, 0, sizeof(max_pmce));
> +       sync_global_to_guest(vpmu_vm.vm, max_pmce);
> +       run_vcpu(vpmu_vm.vcpu);
> +       sync_global_from_guest(vpmu_vm.vm, max_pmce);
> +       destroy_vpmu_vm();
> +
> +       for (int i =3D 0; i < ARRAY_SIZE(used_pmu_events); i++)
> +               set_pmce(&used_pmce, KVM_PMU_EVENT_ALLOW, used_pmu_events=
[i]);
> +
> +       return ((max_pmce.pmceid0 & used_pmce.pmceid0) =3D=3D used_pmce.p=
mceid0) &&
> +              ((max_pmce.pmceid1 & used_pmce.pmceid1) =3D=3D used_pmce.p=
mceid1);
> +}
> +
> +int main(void)
> +{
> +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
> +       TEST_REQUIRE(kvm_pmu_support_events());
> +
> +       run_tests();
> +}
> --
> 2.40.1
>
>

