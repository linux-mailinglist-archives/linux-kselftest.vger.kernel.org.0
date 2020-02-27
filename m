Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F56172408
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 17:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgB0Qxf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 11:53:35 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:16772 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgB0Qxf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 11:53:35 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SzJW5t3qz9tyMh;
        Thu, 27 Feb 2020 17:53:31 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=szBodkbw; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id enQnzjnstZrM; Thu, 27 Feb 2020 17:53:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SzJW4rPgz9tyMf;
        Thu, 27 Feb 2020 17:53:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582822411; bh=05WQ6al5jzZMimryD6lRxQEh3VR9LceJfbJ+E6FUjq0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=szBodkbw9tyFJe+8XAfaFtMeAoCGwJquE4NznxQM3LZpkoZuXXN5rRWLtbTZ+OoZ2
         igGQvvuO+jBqnIXXFrRheeXENZJgaebYckby2HJHuW1pFJtjD6V/VMNFs1B/1+WMsQ
         snPnab3Dv1nIEZaf6Nbgxqo1/9eXMDdTKvWSBhIw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E4938B880;
        Thu, 27 Feb 2020 17:53:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JxAcSkmoZNsM; Thu, 27 Feb 2020 17:53:33 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 082038B799;
        Thu, 27 Feb 2020 17:53:31 +0100 (CET)
Subject: Re: [PATCH] selftest/lkdtm: Use local .gitignore
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <e4ba4f716599d1d66c8bc60489f4b05764ea8470.1582812034.git.christophe.leroy@c-s.fr>
 <202002270817.1C32C98@keescook>
 <f804d7bc-134d-27f8-daa5-6bbf9f28b54d@linuxfoundation.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <30df72ac-dd78-315e-9f00-35320e0ee187@c-s.fr>
Date:   Thu, 27 Feb 2020 17:53:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f804d7bc-134d-27f8-daa5-6bbf9f28b54d@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Le 27/02/2020 à 17:45, Shuah Khan a écrit :
> On 2/27/20 9:17 AM, Kees Cook wrote:
>> On Thu, Feb 27, 2020 at 02:07:10PM +0000, Christophe Leroy wrote:
>>> Commit 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
>>> introduced patterns for git to ignore files generated in
>>> tools/testing/selftests/lkdtm/
>>>
>>> Use local .gitignore file instead of using the root one.
>>>
>>> Fixes: 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> Yeah, that's better. Thanks!
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
> 
> I will apply it for next rc.
> 
> Thanks. I should have noticed the problem in the previous version.
> It slipped by me. :(
> 

My fault, I didn't even know we could have .gitignore in subdirectories.

Christophe
