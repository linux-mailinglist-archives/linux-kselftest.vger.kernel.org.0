Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1493EDF52
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Aug 2021 23:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhHPVbT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Aug 2021 17:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232067AbhHPVbS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Aug 2021 17:31:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E57060F41;
        Mon, 16 Aug 2021 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629149446;
        bh=KEmU9Bigm57pHUOkVoJMJRZUEO1xwhUaBi/gbSqX9B4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ORFM2iqNU5RfMJsDHs1Ztz7RIBTTEqBK3w8IYHyNYME1EBVc9ul5SFqldjMi8A86m
         Ad1yIMoG3Yi+j1leaM40dS59NVGIYTnyRumM74540CvswTDg122rFMYy8239YSdHmO
         +ord3bcHw6zxgQOUyBh1h15PARmcBwWCEhfFzkuD4E0xHXdbE8SVoPvWQ6DMqaEEgX
         IL5d+thWLYXHz5zzQQprwZ8GyFMkkQGG5plWAjioQVl0zXxXhQ22LzNkrDfMPtEp83
         65Ok8F1tL2Xo2uT2X5u2UA7MjE7JH8FcJ9krI091+cddh6BNBIv1xYzyvb84+U79AK
         3pL0TreueU5LA==
Message-ID: <f8674dac5579a8a424de1565f7ffa2b5bf2f8e36.camel@kernel.org>
Subject: Re: [PATCH v4 1/8] x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date:   Tue, 17 Aug 2021 00:30:43 +0300
In-Reply-To: <4bcc069d-fafe-11e8-3fac-135e9ece2eec@linuxfoundation.org>
References: <20210809093127.76264-1-jarkko@kernel.org>
         <20210809093127.76264-2-jarkko@kernel.org>
         <4bcc069d-fafe-11e8-3fac-135e9ece2eec@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2021-08-13 at 11:33 -0600, Shuah Khan wrote:
> Why not add the details you have in the commit log to the document?
> Also add more details on how to debug/test.

Agreed, we can re-use it, thanks for the remark. I'll extend it,=20
but it remains to be seen where exactly it will be documented.

I've started to manage this patch as a separate cycle:

https://lore.kernel.org/linux-sgx/20210812224645.90280-1-jarkko@kernel.org/=
T/#u

I'll CC you the 1st non-RFC version, and hold on with the patch set
under discussion up until we get the kernel change first to the
mainline.

Should happen within couple of days as I think we got quite well
sorted out with Dave last week, what to do next.

/Jarkko
