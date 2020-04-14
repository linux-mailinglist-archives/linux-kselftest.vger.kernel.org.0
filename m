Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552731A81B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437418AbgDNPMV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 11:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437165AbgDNPMR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 11:12:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A7420768;
        Tue, 14 Apr 2020 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586877136;
        bh=jOYnQgEdoWq4y2CKsrYEfzMWlFKzgnaeEaW9TveH6kc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IPRaOyZBtaqJUX/tVd0sTyF9Ot7yOROuyg9Dc35Kq+xIyQ8aDRtgFLwa5JQG0+8WC
         6l38Be47MPOdkKgXoYqL6vPfwTY57TPVvePiOcmzNYJhS9JXjx8i6mEn7UIbOjAjLK
         rfDYYdqfLZqin3P/nGF4EPepHKkXA8O0YnVhC5Jg=
Subject: Re: [PATCH] Revert "Kernel selftests: tpm2: check for tpm support"
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20200412142309.71807-1-jarkko.sakkinen@linux.intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3921a93f-120c-0201-4af5-591bf4e6a0b0@kernel.org>
Date:   Tue, 14 Apr 2020 09:12:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200412142309.71807-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/12/20 8:23 AM, Jarkko Sakkinen wrote:
> This reverts commit b32694cd0724d4ceca2c62cc7c3d3a8d1ffa11fc.
> 
> The original comment

commit I assume.

  was neither reviewed nor tested. Thus, this the
> *only* possible action to take.
> 

Bummer. I will apply this right away.


> Cc: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---

thanks,
-- Shuah

