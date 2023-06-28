Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809AF740B28
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 10:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjF1IWr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 04:22:47 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:13488 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjF1IS7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 04:18:59 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 35S7iT5D060361
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 10:44:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1687938268; x=1690530268;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p8V5keLqZmvghqwdTNhha7x0Up0dRy6dy2mG52JFhz0=;
        b=UwHN5CAQyRm3KAhAmLCvT14b0hj9J0mgCI4yzHrD4xUrQX7s3YzW3+UOyMtHtO4l
        +kkat1O6fQcT7gTx5MaItShLs4i5za8q6SnZxTpko7AAxkDV3mWfRt21iGLKiEMg
        141u7K4iBBVldJpeVFJFkYP85TsewxyDejBLBH+r9sPWEQT7eX3ioA2h+uFnv6u3
        Cin73X6F4fuOYWgMJgMNmU0VhoGAwX9rpqD7zpXVlA71ogRSRha/MIdnBLRMxvcM
        /AdTIEdszr/Lh1ig7xHdZ6cAmjUUjPcSubVBbmT7VKHPuyTW8sr2kU/Cy5uAFlK/
        bXpQDGoxqXU1sae2RAi0dQ==;
X-AuditID: 8b5b014d-a23ec70000002178-01-649be4dc9c9e
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id A3.E5.08568.CD4EB946; Wed, 28 Jun 2023 10:44:28 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <6dc3a208-e180-18b4-c87e-50735edd595b@ics.forth.gr>
Date:   Wed, 28 Jun 2023 10:44:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Content-Language: el-GR, en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, jrtc27@jrtc27.com
Cc:     charlie@rivosinc.com, alexghiti@rivosinc.com,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Bjorn Topel <bjorn@rivosinc.com>,
        anup@brainfault.org, Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, konstantin@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
References: <mhng-7914c1d2-d671-4cc4-ba90-f85acb7c8b50@palmer-ri-x1c9>
From:   Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <mhng-7914c1d2-d671-4cc4-ba90-f85acb7c8b50@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXSHT1dWffOk9kpBpN2qFs8bjzOaNHy4R2r
        xdbfs9gtNv//wmzx9sYrRot7E7+zWKycuorN4sgUO4s9CycyW+z8/IXRYmHbEhaL6Xfes1nc
        W/Of1WLb5xY2iwVH0y3aZvE7CHhM/X2GxeNwxxd2j5Xv37F4bFrVyeax6dMkdo/9c9ewe2xe
        Uu9xY1aEx6Xm6+wenzfJBXBFcdmkpOZklqUW6dslcGXcX76fueAzV8Wa040sDYx3OboYOTkk
        BEwkPmyezdbFyMUhJHCUUWLa50ZmiISlxOZPL1lAbF4Be4lXr56BxVkEVCVaNjYzQcQFJU7O
        fAJWIyoQLbH68wVWEFtYwE9i+vKfjCA2s4CcxPtn28HiIgLWEgcOHGUFWcYscJlZYtGMlWCD
        hATcJDb9eg42iE1AU2L+pYNgNqeAu8SCCfeZIQaZSXRt7YIaKi/RvHU28wRGgVlI7piFZN8s
        JC2zkLQsYGRZxSiQWGasl5lcrJeWX1SSoZdetIkRHHeMvjsYb29+q3eIkYmD8RCjBAezkgiv
        2I/pKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5T9guSBYSSE8sSc1OTS1ILYLJMnFwSjUwHfl9
        5aVUUBHHJcF7/Y8j50tdMu1U/DLliox05Y0v3PKr8jqaPq9xnfd648PUy731PfMs3CsenGt9
        US6wet33SjWFuheP0l6nLz3gIjVPPYL723a+uweiVy9wCV/UqFfnflqgt5VHs3XxYsPNBSKS
        IsJ/8/taHD6caRdM4zp23s2qsrrnT1zj0q4lfOuVnlQbHDXJ5/i89+eOy0/WRd3SVFzaL/l1
        0ZvQkqPml11ELK8vcGkSUzc0d0tS2lv2KSKurkUy10Xm6yuTfT61TC63fzslnD/Xv1jOUJVx
        1l5OEe0lvR/OTMn9fq106u1ZTOdOz5tc8/WH0h5+W4332z5eaF4XXZ07aXbWk08bvRetUGIp
        zkg01GIuKk4EAMjdIykqAwAA
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/28/23 02:36, Palmer Dabbelt wrote:
> On Tue, 27 Jun 2023 15:32:36 PDT (-0700), jrtc27@jrtc27.com wrote:
>> On 27 Jun 2023, at 23:21, Charlie Jenkins <charlie@rivosinc.com> wrote:
>>>
>>> Make sv39 the default address space for mmap as some applications
>>> currently depend on this assumption.
>>
>> They are just plain wrong too. Sv48 was in even Priv v1.10 (the first
>> spec where satp was named as such and contained the mode, rather than
>> requiring M-mode’s help in configuring virtual memory), predating the
>> ratified v1.11 spec. A 39-bit address space is pathetic and has
>> implications for ASLR.
>>
>> I strongly suggest applications be forced to support at least Sv48,
>> which is totally reasonable given the address space sizes used by other
>> architectures. Sv57 is more disruptive to some runtimes, though ideally
>> even that would be free for the kernel to use rather than committing to
>> not using it for the default uABI.
> 
> Go and OpenJDK both broke when we expanded the VA width.  I don't like 
> it either, but if the change breaks userspace then it's a regression and 
> we have to live with the bug.
> 

Have we debugged this ? do we at least know why they break ? Just 
disabling Sv48/57 by default for everyone because some userspace apps 
break doesn't seem the correct approach, it seems more like a bug in 
userspace IMHO.
