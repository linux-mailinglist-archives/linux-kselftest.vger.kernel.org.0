Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6F41A2DAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 04:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDICpw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 22:45:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgDICpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 22:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586400350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMUr6sa1Hx+At9mJ4ctmgYKr/fOyqaI4GOvrCd4ps68=;
        b=e0AR3bbToYUH009XOYW6dll8MfoHJm7LH/uv66YJL6C89jFOfdivt58Qw3+vaKRbypW/pY
        O/dYzr+n/a09gVzVpJotzoYD+l9nUUwceOWmHkCGigW/epsJrn+eKJ34HiNfpQU45H6cZh
        Tksh8KL4DX2A0feTlkrvPkgdHIFiYIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-bMMmtStKPYSY0xL_zzP8RQ-1; Wed, 08 Apr 2020 22:45:48 -0400
X-MC-Unique: bMMmtStKPYSY0xL_zzP8RQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B175518AB2C4;
        Thu,  9 Apr 2020 02:45:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCCF760BFB;
        Thu,  9 Apr 2020 02:45:41 +0000 (UTC)
Subject: Re: [PATCH v4 1/2] selftests: kvm: Add vm_get_fd() in kvm_util
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org
Cc:     drjones@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200408220818.4306-1-wainersm@redhat.com>
 <20200408220818.4306-2-wainersm@redhat.com>
 <734ebc46-ff31-708b-5a2f-8bda248cd290@oracle.com>
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <a21f3ae5-fb4e-1b9d-c8e7-ac4628c763c2@redhat.com>
Date:   Wed, 8 Apr 2020 23:45:39 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <734ebc46-ff31-708b-5a2f-8bda248cd290@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/8/20 10:25 PM, Krish Sadhukhan wrote:
>
> On 4/8/20 3:08 PM, Wainer dos Santos Moschetta wrote:
>> Introduces the vm_get_fd() function in kvm_util which returns
>> the VM file descriptor.
>>
>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>> =C2=A0 tools/testing/selftests/kvm/include/kvm_util.h | 1 +
>> =C2=A0 tools/testing/selftests/kvm/lib/kvm_util.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 5 +++++
>> =C2=A0 2 files changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h=20
>> b/tools/testing/selftests/kvm/include/kvm_util.h
>> index a99b875f50d2..4e122819ee24 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -254,6 +254,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm);
>> =C2=A0 unsigned int vm_get_page_size(struct kvm_vm *vm);
>> =C2=A0 unsigned int vm_get_page_shift(struct kvm_vm *vm);
>> =C2=A0 unsigned int vm_get_max_gfn(struct kvm_vm *vm);
>> +int vm_get_fd(struct kvm_vm *vm);
>> =C2=A0 =C2=A0 unsigned int vm_calc_num_guest_pages(enum vm_guest_mode =
mode,=20
>> size_t size);
>> =C2=A0 unsigned int vm_num_host_pages(enum vm_guest_mode mode, unsigne=
d=20
>> int num_guest_pages);
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c=20
>> b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index 8a3523d4434f..3e36a1eb8771 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -1734,6 +1734,11 @@ unsigned int vm_get_max_gfn(struct kvm_vm *vm)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return vm->max_gfn;
>> =C2=A0 }
>> =C2=A0 +int vm_get_fd(struct kvm_vm *vm)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return vm->fd;
>> +}
>> +
>
>
> I am just trying to understand why we need a separate function when=20
> the 'vm' variable is all local within the same file. There are a=20
> number of places in kvm_util.c where it is used directly.


The problem is to access of kvm_vm attributes outside of kvm_utils.c.=20
For example, if I try to vm->fd in my test I get the compiler error:

mem_slot_test.c: In function =E2=80=98test_add_max_slots=E2=80=99:
mem_slot_test.c:62:16: error: dereferencing pointer to incomplete type=20
=E2=80=98struct kvm_vm=E2=80=99
 =C2=A0 ret =3D ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~

>
>
>> =C2=A0 static unsigned int vm_calc_num_pages(unsigned int num_pages,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsign=
ed int page_shift,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsign=
ed int new_page_shift,
>

