Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0917AA79
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCEQZm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 11:25:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbgCEQZm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 11:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583425541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=upBJ1YaaDvvizCIJlD7zDa27JX49RWsGRLEsXBieMeU=;
        b=ToEOOt4lwDiZOg+Ly3C+UgSxTXRxtg7t8MhwUgr/GTbwteEmaTBIqhA2TaHXlWcXXF+A5/
        3YmBOJQzDytnYxjbJndBr1jc0yp9Ep7p7r5Mg90YP9y7SqQjdzQUtceQobpDgme62/C0Ad
        2zJOPXwQkMHQ22Ph+j8hkJjTG4WuiTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-5tI_py84MuaSwXH-EahB0Q-1; Thu, 05 Mar 2020 11:25:37 -0500
X-MC-Unique: 5tI_py84MuaSwXH-EahB0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE5D6800D4E;
        Thu,  5 Mar 2020 16:25:34 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-226.ams2.redhat.com [10.36.116.226])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2F7B73893;
        Thu,  5 Mar 2020 16:25:25 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        steven@liquorix.net, malteskarupke@web.de, carlos@redhat.com,
        adhemerval.zanella@linaro.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org
Subject: Re: 'simple' futex interface [Was: [PATCH v3 1/4] futex: Implement mechanism to wait on any of several futexes]
References: <20200228190717.GM18400@hirez.programming.kicks-ass.net>
        <20200228194958.GO14946@hirez.programming.kicks-ass.net>
        <87tv3aflqm.fsf@nanos.tec.linutronix.de>
        <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
        <87o8thg031.fsf@nanos.tec.linutronix.de>
        <beb82055-96fa-cb64-a06e-9d7a0946587b@valvesoftware.com>
        <20200303120050.GC2596@hirez.programming.kicks-ass.net>
        <87pndth9ur.fsf@oldenburg2.str.redhat.com>
        <20200303132150.GD2596@hirez.programming.kicks-ass.net>
        <878skhh7og.fsf@oldenburg2.str.redhat.com>
        <20200303150104.GE2596@hirez.programming.kicks-ass.net>
        <52406c54-60b3-dcfe-65d8-4c425459e37b@collabora.com>
Date:   Thu, 05 Mar 2020 17:25:23 +0100
In-Reply-To: <52406c54-60b3-dcfe-65d8-4c425459e37b@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Thu, 5 Mar 2020 13:14:17 -0300")
Message-ID: <87imji7or0.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Andr=C3=A9 Almeida:

> Thanks everyone for the feedback around our mechanism. Are the
> performance benefits of implementing a syscall to wait on a single futex
> significant enough to maintain it instead of just using
> `sys_futex_waitv()` with `nr_waiters =3D 1`? If we join both cases in a
> single interface, we may even add a new member for NUMA hint in `struct
> futex_wait`.

Some seccomp user might want to verify the address, and that's easier if
it's in an argument.  But that's just a rather minor aspect.

Do you propose to drop the storage requirement for the NUMA hint
next to the futex completely?

Thanks,
Florian

