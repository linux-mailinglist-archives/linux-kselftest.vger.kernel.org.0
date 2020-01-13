Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EAB1393C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 15:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgAMOhv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 09:37:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58533 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbgAMOhu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 09:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578926268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bS5GWahrJ1O+34i2WctYNhu18hENHqUcaYD0bIdK6TY=;
        b=iYOxHFSUubtq6GKvdn0gcAOOoeX6oooFliUaKY9TI1op/eSPlaBqXAVa0x1Xo1coieZdCm
        H4Vnqj1WztRoTxsIR1nDRK4su4Y1cnLD1wp141sZ+Fbtwh5+xTirWF0BS0vu+wuyx3oD4X
        yAoCMsoRhY0nYnRlMhhl09yCcuqPCcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-THJL3bLzOKGSiCPXQe6hug-1; Mon, 13 Jan 2020 09:37:45 -0500
X-MC-Unique: THJL3bLzOKGSiCPXQe6hug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35F6718FF660;
        Mon, 13 Jan 2020 14:37:44 +0000 (UTC)
Received: from [10.18.17.119] (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AFA45C21B;
        Mon, 13 Jan 2020 14:37:43 +0000 (UTC)
Subject: Re: [PATCH 0/2] selftests/livepatch: Trivial cleanups
To:     Miroslav Benes <mbenes@suse.cz>, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, shuah@kernel.org
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200113124907.11086-1-mbenes@suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <9cb551f6-1480-328e-9e4a-ac31fcd56a97@redhat.com>
Date:   Mon, 13 Jan 2020 09:37:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113124907.11086-1-mbenes@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/13/20 7:49 AM, Miroslav Benes wrote:
> Two trivial cleanups after recent changes in selftests/livepatch. Based
> on "next" branch of Shuah's kselftest tree.
> 
> Miroslav Benes (2):
>    selftests/livepatch: Replace set_dynamic_debug() with setup_config()
>      in README
>    selftests/livepatch: Remove unused local variable in
>      set_ftrace_enabled()
> 
>   tools/testing/selftests/livepatch/README       | 2 +-
>   tools/testing/selftests/livepatch/functions.sh | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 

For the series:

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe

