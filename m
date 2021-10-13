Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6B42CD94
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Oct 2021 00:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhJMWN6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 18:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229883AbhJMWN5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 18:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634163113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JmNllblB/cMMbHhwVjswqlhts6bUBeMmcJX0XzZQCXY=;
        b=K9pGbCPG/SOaxdCrTiJK5Ev+SmRpv1Cnq4S0LUTX7jH3phYDEF92Zy0mkN3d6LlJr8DqWY
        mi0P18cXZbB2MB8zwK7uaz8yM2HERr0rYWV1gH5ZWk+zAEtbys1LeaIB2JGnkgHfp3tmIV
        tGiMUnkjheqAfozZjPO0nJhji5tMmzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-ETx3FszKMweJdLE2ipqRLA-1; Wed, 13 Oct 2021 18:11:50 -0400
X-MC-Unique: ETx3FszKMweJdLE2ipqRLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3596A802921;
        Wed, 13 Oct 2021 22:11:48 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.33.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0279D5F4F9;
        Wed, 13 Oct 2021 22:11:38 +0000 (UTC)
Subject: Re: [PATCH v7 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
From:   Waiman Long <longman@redhat.com>
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Waiman Long <llong@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com> <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
 <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
 <YShjb2WwvuB4s4gX@slm.duckdns.org>
 <d22ea3be-2429-5923-a80c-5af3b384def9@redhat.com>
 <YSlY0H/qeXQIGOfk@slm.duckdns.org>
 <392c3724-f583-c7fc-cfa1-a3f1665114c9@redhat.com>
 <YSl2yxEvnDrPxzUV@slm.duckdns.org>
 <3533e4f9-169c-d13c-9c4e-d9ec6bdc78f0@redhat.com>
 <20211012143913.GA22036@blackbody.suse.cz>
 <5eacfdcc-148b-b599-3111-4f2971e7ddc0@redhat.com>
Message-ID: <306d7fca-ee8a-e5dc-973e-5255d73de71f@redhat.com>
Date:   Wed, 13 Oct 2021 18:11:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5eacfdcc-148b-b599-3111-4f2971e7ddc0@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------B9F95CE910141AE77C835857"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------B9F95CE910141AE77C835857
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/21 5:45 PM, Waiman Long wrote:
>
>
>>
>> In conclusion, it'd be good to have validity conditions separate from
>> transition conditions (since hotplug transition can't be rejected) and
>> perhaps treat administrative changes from an ancestor equally as a
>> hotplug.
>
> I am trying to make the result of changing "cpuset.cpus" as close to 
> hotplug as possible but there are cases where the "cpuset.cpus" change 
> is prohibited but hotplug can still happen to remove the cpu.
>
> Hope this will help to clarify the current design.
>
BTW, the attached file is the current draft of cpuset.cpus.partition 
document.

Cheers,
Longman


--------------B9F95CE910141AE77C835857
Content-Type: text/plain; charset=UTF-8;
 name="cpuset.cpus.partition.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cpuset.cpus.partition.txt"

ICBjcHVzZXQuY3B1cy5wYXJ0aXRpb24KCUEgcmVhZC13cml0ZSBzaW5nbGUgdmFsdWUgZmls
ZSB3aGljaCBleGlzdHMgb24gbm9uLXJvb3QKCWNwdXNldC1lbmFibGVkIGNncm91cHMuICBU
aGlzIGZsYWcgaXMgb3duZWQgYnkgdGhlIHBhcmVudCBjZ3JvdXAKCWFuZCBpcyBub3QgZGVs
ZWdhdGFibGUuCgoJSXQgYWNjZXB0cyBvbmx5IHRoZSBmb2xsb3dpbmcgaW5wdXQgdmFsdWVz
IHdoZW4gd3JpdHRlbiB0by4KCgkgID09PT09PT09CT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CgkgICJtZW1iZXIiCU5vbi1yb290IG1lbWJlciBvZiBhIHBhcnRpdGlvbgoJ
ICAicm9vdCIJUGFydGl0aW9uIHJvb3QKCSAgImlzb2xhdGVkIglQYXJ0aXRpb24gcm9vdCB3
aXRob3V0IGxvYWQgYmFsYW5jaW5nCgkgID09PT09PT09CT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09CgoJV2hlbiBzZXQgdG8gYmUgYSBwYXJ0aXRpb24gcm9vdCwgdGhlIGN1
cnJlbnQgY2dyb3VwIGlzIHRoZQoJcm9vdCBvZiBhIG5ldyBwYXJ0aXRpb24gb3Igc2NoZWR1
bGluZyBkb21haW4gdGhhdCBjb21wcmlzZXMKCWl0c2VsZiBhbmQgYWxsIGl0cyBkZXNjZW5k
YW50cyBleGNlcHQgdGhvc2UgdGhhdCBhcmUgc2VwYXJhdGUKCXBhcnRpdGlvbiByb290cyB0
aGVtc2VsdmVzIGFuZCB0aGVpciBkZXNjZW5kYW50cy4gIFRoZSByb290CgljZ3JvdXAgaXMg
YWx3YXlzIGEgcGFydGl0aW9uIHJvb3QuCgoJV2hlbiBzZXQgdG8gImlzb2xhdGVkIiwgdGhl
IENQVXMgaW4gdGhhdCBwYXJ0aXRpb24gcm9vdCB3aWxsCgliZSBpbiBhbiBpc29sYXRlZCBz
dGF0ZSB3aXRob3V0IGFueSBsb2FkIGJhbGFuY2luZyBmcm9tIHRoZQoJc2NoZWR1bGVyLiAg
VGFza3MgaW4gc3VjaCBhIHBhcnRpdGlvbiBtdXN0IGJlIGV4cGxpY2l0bHkgYm91bmQKCXRv
IGVhY2ggaW5kaXZpZHVhbCBDUFUuCgoJImNwdXNldC5jcHVzIiBtdXN0IGFsd2F5cyBiZSBz
ZXQgdXAgZmlyc3QgYmVmb3JlIGVuYWJsaW5nCglwYXJ0aXRpb24uICBVbmxpa2UgIm1lbWJl
ciIgd2hvc2UgImNwdXNldC5jcHVzLmVmZmVjdGl2ZSIgY2FuCgljb250YWluIENQVXMgbm90
IGluICJjcHVzZXQuY3B1cyIsIHRoaXMgY2FuIG5ldmVyIGhhcHBlbiB3aXRoIGEKCXZhbGlk
IHBhcnRpdGlvbiByb290LiAgSW4gb3RoZXIgd29yZHMsICJjcHVzZXQuY3B1cy5lZmZlY3Rp
dmUiCglpcyBhbHdheXMgYSBzdWJzZXQgb2YgImNwdXNldC5jcHVzIiBmb3IgYSB2YWxpZCBw
YXJ0aXRpb24gcm9vdC4KCglXaGVuIGEgcGFyZW50IHBhcnRpdGlvbiByb290IGNhbm5vdCBl
eGNsdXNpdmVseSBncmFudCBhbnkgb2YKCXRoZSBDUFVzIHNwZWNpZmllZCBpbiAiY3B1c2V0
LmNwdXMiLCAiY3B1c2V0LmNwdXMuZWZmZWN0aXZlIgoJYmVjb21lcyBlbXB0eS4gSWYgdGhl
cmUgYXJlIHRhc2tzIGluIHRoZSBwYXJ0aXRpb24gcm9vdCwgdGhlCglwYXJ0aXRpb24gcm9v
dCBiZWNvbWVzIGludmFsaWQgYW5kICJjcHVzZXQuY3B1cy5lZmZlY3RpdmUiCglpcyByZXNl
dCB0byB0aGF0IG9mIHRoZSBuZWFyZXN0IG5vbi1lbXB0eSBhbmNlc3Rvci4KCiAgICAgICAg
Tm90ZSB0aGF0IGEgdGFzayBjYW5ub3QgYmUgbW92ZWQgdG8gYSBjZ3JvdXAgd2l0aCBlbXB0
eQogICAgICAgICJjcHVzZXQuY3B1cy5lZmZlY3RpdmUiLgoKCVRoZXJlIGFyZSBhZGRpdGlv
bmFsIGNvbnN0cmFpbnRzIG9uIHdoZXJlIGEgcGFydGl0aW9uIHJvb3QgY2FuCgliZSBlbmFi
bGVkICgicm9vdCIgb3IgImlzb2xhdGVkIikuICBJdCBjYW4gb25seSBiZSBlbmFibGVkIGlu
CglhIGNncm91cCBpZiBhbGwgdGhlIGZvbGxvd2luZyBjb25kaXRpb25zIGFyZSBtZXQuCgoJ
MSkgVGhlICJjcHVzZXQuY3B1cyIgaXMgbm9uLWVtcHR5IGFuZCBleGNsdXNpdmUsIGkuZS4g
dGhleSBhcmUKCSAgIG5vdCBzaGFyZWQgYnkgYW55IG9mIGl0cyBzaWJsaW5ncy4KCTIpIFRo
ZSBwYXJlbnQgY2dyb3VwIGlzIGEgdmFsaWQgcGFydGl0aW9uIHJvb3QuCgkzKSBUaGUgImNw
dXNldC5jcHVzIiBpcyBhIHN1YnNldCBvZiBwYXJlbnQncyAiY3B1c2V0LmNwdXMiLgoJNCkg
VGhlcmUgaXMgbm8gY2hpbGQgY2dyb3VwcyB3aXRoIGNwdXNldCBlbmFibGVkLiAgVGhpcyBh
dm9pZHMKCSAgIGNwdSBtaWdyYXRpb25zIG9mIG11bHRpcGxlIGNncm91cHMgc2ltdWx0YW5l
b3VzbHkgd2hpY2ggY2FuCgkgICBiZSBwcm9ibGVtYXRpYy4KCglPbiByZWFkLCB0aGUgImNw
dXNldC5jcHVzLnBhcnRpdGlvbiIgZmlsZSBjYW4gc2hvdyB0aGUgZm9sbG93aW5nCgl2YWx1
ZXMuCgoJICA9PT09PT09PT09PT09PT09PT09PT09CT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQoJICAibWVtYmVyIgkJCU5vbi1yb290IG1lbWJlciBvZiBhIHBhcnRpdGlvbgoJ
ICAicm9vdCIJCQlQYXJ0aXRpb24gcm9vdAoJICAiaXNvbGF0ZWQiCQkJUGFydGl0aW9uIHJv
b3Qgd2l0aG91dCBsb2FkIGJhbGFuY2luZwoJICAicm9vdCBpbnZhbGlkICg8cmVhc29uPiki
CUludmFsaWQgcGFydGl0aW9uIHJvb3QKCSAgPT09PT09PT09PT09PT09PT09PT09PQk9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KCiAgICAgICAgSW4gdGhlIGNhc2Ugb2YgYW4g
aW52YWxpZCBwYXJ0aXRpb24gcm9vdCwgYSBkZXNjcmlwdGl2ZSBzdHJpbmcgb24KICAgICAg
ICB3aHkgdGhlIHBhcnRpdGlvbiBpcyBpbnZhbGlkIGlzIGluY2x1ZGVkIHdpdGhpbiBwYXJl
bnRoZXNlcy4KCglPbmNlIGJlY29taW5nIGEgcGFydGl0aW9uIHJvb3QsIGNoYW5nZXMgdG8g
ImNwdXNldC5jcHVzIiBpcwoJZ2VuZXJhbGx5IGFsbG93ZWQgYXMgbG9uZyBhcyB0aGUgY3B1
IGxpc3QgaXMgZXhjbHVzaXZlIGFuZCBpcwoJYSBzdXBlcnNldCBvZiBjaGlsZHJlbidzIGNw
dSBsaXN0cy4KCiAgICAgICAgVGhlIGNvbnN0cmFpbnRzIG9mIGEgdmFsaWQgcGFydGl0aW9u
IHJvb3QgYXJlIGFzIGZvbGxvd3M6CgogICAgICAgIDEpICJjcHVzZXQuY3B1cyIgaXMgbm9u
LWVtcHR5IGFuZCBleGNsdXNpdmUuCiAgICAgICAgMikgVGhlIHBhcmVudCBjZ3JvdXAgaXMg
YSB2YWxpZCBwYXJ0aXRpb24gcm9vdC4KICAgICAgICAzKSAiY3B1c2V0LmNwdXMuZWZmZWN0
aXZlIiBpcyBhIHN1YnNldCBvZiAiY3B1c2V0LmNwdXMiCiAgICAgICAgNCkgImNwdXNldC5j
cHVzLmVmZmVjdGl2ZSIgaXMgbm9uLWVtcHR5IHdoZW4gdGhlcmUgYXJlIHRhc2tzCiAgICAg
ICAgICAgaW4gdGhlIHBhcnRpdGlvbi4KCglDaGFuZ2VzIHRvICJjcHVzZXQuY3B1cyIgb3Ig
Y3B1IGhvdHBsdWcgbWF5IGNhdXNlIHRoZSBzdGF0ZQoJb2YgYSB2YWxpZCBwYXJ0aXRpb24g
cm9vdCB0byBiZWNvbWUgaW52YWxpZCB3aGVuIG9uZSBvciBtb3JlCgljb25zdHJhaW50cyBv
ZiBhIHZhbGlkIHBhcnRpdGlvbiByb290IGFyZSB2aW9sYXRlZC4gIFRoZXJlZm9yZSwKCXVz
ZXIgc3BhY2UgYWdlbnRzIHRoYXQgbWFuYWdlIHBhcnRpdGlvbiByb290cyBzaG91bGQgYXZv
aWQKCXVubmVjZXNzYXJ5IGNoYW5nZXMgdG8gImNwdXNldC5jcHVzIiBhbmQgYWx3YXlzIGNo
ZWNrIHRoZSBzdGF0ZQoJb2YgImNwdXNldC5jcHVzLnBhcnRpdGlvbiIgYWZ0ZXIgbWFraW5n
IGNoYW5nZXMgdG8gbWFrZSBzdXJlCgl0aGF0IHRoZSBwYXJ0aXRpb25zIGFyZSBmdW5jdGlv
bmluZyBwcm9wZXJseSBhcyBleHBlY3RlZC4KCiAgICAgICAgQ2hhbmdpbmcgYSBwYXJ0aXRp
b24gcm9vdCB0byAibWVtYmVyIiBpcyBhbHdheXMgYWxsb3dlZC4KICAgICAgICBJZiB0aGVy
ZSBhcmUgY2hpbGQgcGFydGl0aW9uIHJvb3RzIHVuZGVybmVhdGggaXQsIGhvd2V2ZXIsCiAg
ICAgICAgdGhleSB3aWxsIGJlIGZvcmNlZCB0byBiZSBzd2l0Y2hlZCBiYWNrIHRvICJtZW1i
ZXIiIHRvbyBhbmQKICAgICAgICBsb3NlIHRoZWlyIHBhcnRpdGlvbnMuIFNvIGNhcmUgbXVz
dCBiZSB0YWtlbiB0byBkb3VibGUgY2hlY2sKICAgICAgICBmb3IgdGhpcyBjb25kaXRpb24g
YmVmb3JlIGRpc2FibGluZyBhIHBhcnRpdGlvbiByb290LgoKCVNldHRpbmcgYSBjZ3JvdXAg
dG8gYSB2YWxpZCBwYXJ0aXRpb24gcm9vdCB3aWxsIHRha2UgdGhlIENQVXMKCWF3YXkgZnJv
bSB0aGUgZWZmZWN0aXZlIENQVXMgb2YgdGhlIHBhcmVudCBwYXJ0aXRpb24uCgoJQSB2YWxp
ZCBwYXJlbnQgcGFydGl0aW9uIG1heSBkaXN0cmlidXRlIG91dCBhbGwgaXRzIENQVXMgdG8K
CWl0cyBjaGlsZCBwYXJ0aXRpb25zIGFzIGxvbmcgYXMgaXQgaXMgbm90IHRoZSByb290IGNn
cm91cCBhcwoJd2UgbmVlZCBzb21lIGhvdXNlLWtlZXBpbmcgQ1BVcyBpbiB0aGUgcm9vdCBj
Z3JvdXAuCgoJQW4gaW52YWxpZCBwYXJ0aXRpb24gaXMgbm90IGEgcmVhbCBwYXJ0aXRpb24g
ZXZlbiB0aG91Z2ggc29tZQoJaW50ZXJuYWwgc3RhdGVzIG1heSBzdGlsbCBiZSBrZXB0LgoK
CUFuIGludmFsaWQgcGFydGl0aW9uIHJvb3QgY2FuIGJlIHJldmVydGVkIGJhY2sgdG8gYSBy
ZWFsCglwYXJ0aXRpb24gcm9vdCBpZiBub25lIG9mIHRoZSBjb25zdHJhaW50cyBvZiBhIHZh
bGlkIHBhcnRpdGlvbgogICAgICAgIHJvb3QgYXJlIHZpb2xhdGVkLgoKCVBvbGwgYW5kIGlu
b3RpZnkgZXZlbnRzIGFyZSB0cmlnZ2VyZWQgd2hlbmV2ZXIgdGhlIHN0YXRlIG9mCgkiY3B1
c2V0LmNwdXMucGFydGl0aW9uIiBjaGFuZ2VzLiAgVGhhdCBpbmNsdWRlcyBjaGFuZ2VzIGNh
dXNlZCBieQoJd3JpdGUgdG8gImNwdXNldC5jcHVzLnBhcnRpdGlvbiIsIGNwdSBob3RwbHVn
IGFuZCBvdGhlciBjaGFuZ2VzCgl0aGF0IG1ha2UgdGhlIHBhcnRpdGlvbiBpbnZhbGlkLiAg
VGhpcyB3aWxsIGFsbG93IHVzZXIgc3BhY2UKCWFnZW50cyB0byBtb25pdG9yIHVuZXhwZWN0
ZWQgY2hhbmdlcyB0byAiY3B1c2V0LmNwdXMucGFydGl0aW9uIgoJd2l0aG91dCB0aGUgbmVl
ZCB0byBkbyBjb250aW51b3VzIHBvbGxpbmcuCgo=
--------------B9F95CE910141AE77C835857--

