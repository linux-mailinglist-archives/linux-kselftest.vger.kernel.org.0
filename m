Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D881E5A59
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgE1IGJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 04:06:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36405 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbgE1IGI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 04:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590653167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/A7U1eX3P3zNwvhg2WSo20I7YadGS8TVdB6GLHa5NLI=;
        b=BwheoKzsKR/5txe9U74s6D1o1Mv8DlQ7mgjJuLUQL2dwJZzewEEKoUu5V+Mlz1TSqBPw06
        A2isjbbX1B67o6mhzGy9dDfj0NXyw84OZKjpVnUdwaAompE64/ebzZYZSFQrJdaGJqXG6q
        R6BNAx0bSYw0agqWb86G/LiYquN+ZTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-B_reQBTVMvavJnFNHpyU-w-1; Thu, 28 May 2020 04:06:05 -0400
X-MC-Unique: B_reQBTVMvavJnFNHpyU-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFCBD800D24;
        Thu, 28 May 2020 08:06:03 +0000 (UTC)
Received: from localhost (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 521C819D82;
        Thu, 28 May 2020 08:05:59 +0000 (UTC)
Date:   Thu, 28 May 2020 10:05:57 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     shuah <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
Message-ID: <20200528100557.20489f04@redhat.com>
In-Reply-To: <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
References: <xuny367so4k3.fsf@redhat.com>
        <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
        <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
        <xunya71uosvv.fsf@redhat.com>
        <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
        <xuny367lq1z1.fsf@redhat.com>
        <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
        <xunyh7w1nwem.fsf@redhat.com>
        <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
        <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
        <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
> I prefer to keep selftests/bpf install broken.
> This forced marriage between kselftests and selftests/bpf
> never worked well. I think it's a time to free them up from each other.

Alexei, it would be great if you could cooperate with other people
instead of pushing your own way. The selftests infrastructure was put
to the kernel to have one place for testing. Inventing yet another way
to add tests does not help anyone. You don't own the kernel. We're
community, we should cooperate.

 Jiri

