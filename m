Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42281E815F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgE2PMY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 11:12:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58010 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbgE2PMY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 11:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590765143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NyeQg8ZregT21iKXzyH6UaHW5smbt/BetQWzJvj6THg=;
        b=aR7hzEvB/ZIRWuS+SH/PY5P64zPz+d8A8CA7Whu86KgZlNn8M9nX0r7khrLeuhyNmAguse
        2TwcsfLlOPPRb5hDzmHCXC9mHy1777QuSHl2VJnADpJQsgbCuQyNGHpA18jJnbM0g9SX06
        3O4KsHqc+EIud1/1Jcboytab2lgMSuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-3mr9cXEzNi-tw5PBq78Uwg-1; Fri, 29 May 2020 11:12:21 -0400
X-MC-Unique: 3mr9cXEzNi-tw5PBq78Uwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21B32107ACCD;
        Fri, 29 May 2020 15:12:20 +0000 (UTC)
Received: from [10.3.112.17] (ovpn-112-17.phx2.redhat.com [10.3.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B4607A8C9;
        Fri, 29 May 2020 15:12:19 +0000 (UTC)
Subject: Re: [PATCH 0/4] selftests/livepatch: rework of
 test-klp-{callbacks,shadow_vars}
To:     Yannick Cote <ycote@redhat.com>, live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org
References: <20200528134849.7890-1-ycote@redhat.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <4d69a69d-480c-5abc-1d26-e107012041dd@redhat.com>
Date:   Fri, 29 May 2020 11:12:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528134849.7890-1-ycote@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/28/20 9:48 AM, Yannick Cote wrote:
> The test-klp-callbacks change implement a synchronization replacement of
> initial code to use completion variables instead of delays. The
> completion variable interlocks the busy module with the concurrent
> loading of the target livepatch patches which works with the execution
> flow instead of estimated time delays.
> 

For more context: we had been seeing occasional glitches with this test 
in our continuous kernel integration suite.  In every case, it seemed 
that the worker thread wasn't running when expected, so I assumed that 
system load had something to do with it.  We shuffled the ordering of 
tests, but still encountered issues and I decided life was too sort to 
continue remotely debugging sleep-"synchronized" code.

> The test-klp-shadow-vars changes first refactors the code to be more of
> a readable example as well as continuing to verify the component code.
> The patch is broken in two to display the renaming and restructuring in
> part 1 and the addition and change of logic in part 2. The last change
> frees memory before bailing in case of errors.
> 

Yannick's patches look fine to me, so for those:

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

(I can ack individually if required, let me know.)

-- Joe

