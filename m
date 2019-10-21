Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF32DF449
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfJURa5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 13:30:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39869 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJURa5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 13:30:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so3521623edr.6;
        Mon, 21 Oct 2019 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cFOMVAAaWO9r1HyVs3s38A5PI9l0KJcbRDhoClQ2L/4=;
        b=d7LItyFEwEpkOx5goveDgpSeSiKU1rnmH8ayouif2ED/JlJ5toyvC5/4e7mQ2onI0I
         +vsNR7J7gROTTBQ2UEjUR+8cWUgk0PiWkRQ53SkBLwU1Qm/Zn2tc3m4gA5xRIm088ktA
         ddvIeUOhmFAB7ni8Sq9b+J9ZMiGck5uaS1ETvhhYQMKP66NRQFSphYUZarhHGEEJXT1T
         XIVQP4uyAwYXmf8eIJhgSm5ETxvNriSHuZ+FoBs8r6Q1VdO0sa7U+fFFvn28JNBLd0ND
         Quo0Vrw4yqotJne8/DAgNGl604Dnn2QKHF09gH1lPF602VnHF38Pf8nlnubDlZP39D9M
         VNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cFOMVAAaWO9r1HyVs3s38A5PI9l0KJcbRDhoClQ2L/4=;
        b=dGaY8lxgbT73aHm0Y9/7XE9yaTi66TqOIIJ4cNeA/q8bBkVOtsDT7Kb47LGRW6sSp0
         e+sh+Xx0iblgo4y4jBMMaZF7p1QdQPZJNRPs1CqcMOoANM8XjR5JTfP3X98zis17AfBO
         CehhgxY6KPutq/Z+Q7mWcrwQwqxYGxRbD4JidlfF5quO6+O5s8X84F61kNuppHtomjj4
         mn3trDE71k4JdCiDG6UXsjnEixlnYSVZeIkPmcjwP6/snbmULO1SgKH69ctT5H/M5Yr+
         sk5V8HYIAn6Dz9/C4sCBst8DXoMpH1Gs2kxE5bIscxYPPMoLFcjOeUbiraYQo+vxuvda
         D3EQ==
X-Gm-Message-State: APjAAAW5KQo2NVhE4QUEkPFDtX1merbx5K8+2jaSQXOUBjBFsyc/VPQ/
        RFHpIfeDE0CSXKdIHqWoYg==
X-Google-Smtp-Source: APXvYqzIJjHU7pBX70JXQZO8YOb6VNmtI++0zzXCoAZeAMhoIv9UhLZXgKhJ0tfey7hT3C7umtnaSg==
X-Received: by 2002:a17:906:1343:: with SMTP id x3mr23328255ejb.113.1571679055867;
        Mon, 21 Oct 2019 10:30:55 -0700 (PDT)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id h23sm164324edj.77.2019.10.21.10.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 10:30:55 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:30:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH v2 1/5] selftests: proc: Make va_max 1GB on 32bit
 arch
Message-ID: <20191021173053.GB5355@avx2>
References: <157164647813.17692.3834082082658965225.stgit@devnote2>
 <157164648909.17692.6080553792829040898.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157164648909.17692.6080553792829040898.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 21, 2019 at 05:28:09PM +0900, Masami Hiramatsu wrote:
> Currently proc-self-map-files-002.c sets va_max (max test address
> of user virtual address) to 4GB, but it is too big for 32bit
> arch and 1UL << 32 is overflow on 32bit long.
> 
> Make va_max 1GB on 32bit arch like i386 and arm.

> +#if __BITS_PER_LONG == 32
> +# define VA_MAX (1UL << 30)
> +#elif __BITS_PER_LONG == 64
> +# define VA_MAX (1UL << 32)
> +#else
> +# define VA_MAX 0
> +#endif
> +
>  int main(void)
>  {
>  	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
> -	const unsigned long va_max = 1UL << 32;
> +	const unsigned long va_max = VA_MAX;

No, just make it like 1MB unconditionally.
This is not intended to cover all address space, just large enough part
(larger than reasonable vm.mmap_min_addr)
