Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2781BB739
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Apr 2020 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgD1HH6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Apr 2020 03:07:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47250 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725917AbgD1HH6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Apr 2020 03:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588057677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1RLQ+qnuaFDd8UwJvPaKMyNwSzawA8K8LvFLCADqqg=;
        b=QG0Uy9DLVJTk4xCdc721UOUnN5nngc8tbYthQH0z92zKgYNsRXBF0ErFU/x+gk9qMCvk1I
        Q782CHJR3Jtkol/Q/WizAvHsqOOaV86Wp5cFXqVMQkkoxoviVowrFhOPXiJGuOeKuiSAfb
        THNZCUHXRQxItbEdUbAotdoPJKGj8z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-d3F40KZOOyqaCfk0j4kvQQ-1; Tue, 28 Apr 2020 03:07:55 -0400
X-MC-Unique: d3F40KZOOyqaCfk0j4kvQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3552C462;
        Tue, 28 Apr 2020 07:07:54 +0000 (UTC)
Received: from elisabeth (unknown [10.36.110.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5644272A7;
        Tue, 28 Apr 2020 07:07:52 +0000 (UTC)
Date:   Tue, 28 Apr 2020 09:07:47 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     shuah <shuah@kernel.org>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
Message-ID: <20200428090747.1f1c0649@elisabeth>
In-Reply-To: <bd179be3-2515-1efb-ba95-3c223d573753@kernel.org>
References: <20200427192141.2926018-1-vkabatov@redhat.com>
        <20200427212405.2747394d@redhat.com>
        <bd179be3-2515-1efb-ba95-3c223d573753@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 27 Apr 2020 18:17:27 -0600
shuah <shuah@kernel.org> wrote:

> I don't see this in my Inbox. Please include everybody get_maintainers
> script tells you to do.

Strange, the copy I have has you in To: and linux-kselftest in Cc:, and
yet it's not even on linux-kselftest archives. :( It looks like some MTA
issue on our side...

-- 
Stefano

