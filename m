Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEDFC62E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2019 13:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNMQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Nov 2019 07:16:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56190 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbfKNMQg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Nov 2019 07:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573733795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6g3FuiSmJL+Kk/iwiMI9WeS/k56NyXnRD61zjnDeFo8=;
        b=FgUb18rJYBpY3BqjhKW2vkSvWaCTpKNXT9guGpehwwcaiv7hYeuk1mZi7QC0efACTt3+m9
        qaftkY75WZ36J+AWHyBZS4wo4ztlnU7tTawOQ2n1hLfJAcOgu7xMMj5U/efDsAZRZGGZVb
        BBI3QeaJYuJfnMLr2seV1WmbMrRynDE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-njoMZ3CdN6eTnPgVuJ0Stg-1; Thu, 14 Nov 2019 07:16:32 -0500
Received: by mail-wr1-f70.google.com with SMTP id q6so4303249wrv.11
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2019 04:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbG6hQQW5/T3L1JRr4XcKwwPNPz10SDjCnOLcci1gTs=;
        b=Kl4msHxlzcYtcio4laRJPqEdchWw/2o2Zs6ztkhZoKLlYBMcWhXDKo2eAFzAnAVLeE
         hxVY6bRcDLVGrRYXNKWeJNlG7Aot6I7Jygcmstd4jT+vXqPDf/f3VR1JB83kQSNzBJ/Y
         +iIqZw47jS46dyjTTyzSnEzWx2QQwsHKbGeRJBZeuDtMZrVfKo+oHpJeG+ezheu2APv3
         xWXVotnWycX5mgx9C1L79EYjrVJClrw9rNeg1F8+ZFz5e9S8TbQvfj6bWI0ZI2FbeJU+
         403k6uK7Wj6a4RPDw0HRHOig4CWaFPJUabIxPlVLpN39GZ8Agfy3nIivcgXNTGdII2sj
         jowA==
X-Gm-Message-State: APjAAAV29n1RnMivvp3YxyUmobuoSXcK9wQEjKJg1S3ra0lEmIDjmOwh
        6KL+OkSQxaEEB8dpn4cV0KTE3Sj8oP4SpYlgWgCawfl8LEtB6tgV2pwPTV9cK6chYV0rGmjq77d
        gnweKpHUVzzbrNl+ftkiR256+sP9P
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr7299103wmd.33.1573733791355;
        Thu, 14 Nov 2019 04:16:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwm8L07aob9pGVI1BqTnXUFu0oi7C7NBJZTfOSxIoMVifSd1LDxfNMr/utRbXLIyyw76nANLw==
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr7299081wmd.33.1573733791064;
        Thu, 14 Nov 2019 04:16:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc? ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
        by smtp.gmail.com with ESMTPSA id w13sm6588216wrm.8.2019.11.14.04.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 04:16:30 -0800 (PST)
Subject: Re: [PATCH] selftests: kvm: Simplify loop in kvm_create_max_vcpus
 test
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        rkrcmar@redhat.com
Cc:     shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112142111.13528-1-wainersm@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70986b1a-5a04-cbd6-fe1a-fda4d97d5a72@redhat.com>
Date:   Thu, 14 Nov 2019 13:16:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191112142111.13528-1-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: njoMZ3CdN6eTnPgVuJ0Stg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/11/19 15:21, Wainer dos Santos Moschetta wrote:
> On kvm_create_max_vcpus test remove unneeded local
> variable in the loop that add vcpus to the VM.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/t=
esting/selftests/kvm/kvm_create_max_vcpus.c
> index 231d79e57774..6f38c3dc0d56 100644
> --- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> @@ -29,12 +29,9 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcp=
us)
> =20
>  =09vm =3D vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
> =20
> -=09for (i =3D 0; i < num_vcpus; i++) {
> -=09=09int vcpu_id =3D first_vcpu_id + i;
> -
> +=09for (i =3D first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
>  =09=09/* This asserts that the vCPU was created. */
> -=09=09vm_vcpu_add(vm, vcpu_id);
> -=09}
> +=09=09vm_vcpu_add(vm, i);
> =20
>  =09kvm_vm_free(vm);
>  }
>=20

Queued, thanks.

Paolo

