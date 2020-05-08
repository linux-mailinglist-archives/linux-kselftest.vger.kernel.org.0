Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872701CB8C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 22:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEHUDr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 16:03:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60826 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHUDr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 16:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588968226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X5kwfCZ8GEMui0d70gWIkFX2ZjpyuOsqtOJu+2yxxqE=;
        b=gx05R/wTArLhPODMu+I1V3hlIDLkvx7VC6Ia9OR+C3DoI25ulGp9lkLGU/olt0s+Qzg0qG
        BPydLpizWqI/XkDP2Se7sgK8bMdQmpdBQjWNmkuYf6HcK7DjOCfjQglNXkQpjfhznzWV1p
        S8cwPGailOadxhCOWWix6s/iI+CrdfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-enATtp9oPj2wo-KN0UthHg-1; Fri, 08 May 2020 16:03:26 -0400
X-MC-Unique: enATtp9oPj2wo-KN0UthHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F6401005510;
        Fri,  8 May 2020 20:03:25 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-187.ams2.redhat.com [10.36.113.187])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 607B8702EC;
        Fri,  8 May 2020 20:03:22 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linuxram@us.ibm.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH 2/2] selftests: vm: pkeys: Fix powerpc access right updates
References: <cover.1588959697.git.sandipan@linux.ibm.com>
        <cover.1588959697.git.sandipan@linux.ibm.com>
        <5f65cf37be993760de8112a88da194e3ccbb2bf8.1588959697.git.sandipan@linux.ibm.com>
        <87blmymhkx.fsf@oldenburg2.str.redhat.com>
        <a40c364d-e204-1d63-c211-7cdfdccb32e0@linux.ibm.com>
Date:   Fri, 08 May 2020 22:03:20 +0200
In-Reply-To: <a40c364d-e204-1d63-c211-7cdfdccb32e0@linux.ibm.com> (Sandipan
        Das's message of "Sat, 9 May 2020 01:24:26 +0530")
Message-ID: <87mu6ii48n.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Sandipan Das:

> Hi Florian,
>
> On 08/05/20 11:31 pm, Florian Weimer wrote:
>> * Sandipan Das:
>> 
>>> The Power ISA mandates that all writes to the Authority
>>> Mask Register (AMR) must always be preceded as well as
>>> succeeded by a context-synchronizing instruction. This
>>> applies to both the privileged and unprivileged variants
>>> of the Move To AMR instruction.
>> 
>> Ugh.  Do you have a reference for that?
>> 
>> We need to fix this in glibc.
>> 
>
> This is from Table 6 of Chapter 11 in page 1134 of Power
> ISA 3.0B. The document can be found here:
> https://ibm.ent.box.com/s/1hzcwkwf8rbju5h9iyf44wm94amnlcrv

Thanks a lot!  I filed:

  <https://sourceware.org/bugzilla/show_bug.cgi?id=25954>

Florian

