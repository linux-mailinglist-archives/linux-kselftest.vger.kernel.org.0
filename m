Return-Path: <linux-kselftest+bounces-8758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC08B0378
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 09:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9381F21DEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 07:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD1F1581FC;
	Wed, 24 Apr 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Hptc5V2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC643AB4
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945032; cv=none; b=DYIUd+CrVGcl0PgAXOUJNUbbMXVRy+mQceHvz6OeSGLWPQwehpQdl+s0nsRXzqPMOqwu6kveI+B1s3ORvq/qK8z1areSacaWcQpalSL9VP8PqBsaHQ2x96VfXyfKUdZ3isZLVNmZy5OE9peFAlKxvlLIf06oYIyEC5i6jIy1RX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945032; c=relaxed/simple;
	bh=g/Er6GYXVGaNH7JDBFXh3LSSvzcGk3gWsJG0AOM4CTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfrNygCd0ZH/C9V1uc5wNVRlYofp+IAXHVvGbL7RTY8k6eIsULmh+J5z4mJEKrLrRuqI50iY7puVs4D20ZT4usXckCHx7vSL3cxp8Zg3SkDPZL3QSGC1O4Emi7mzZtOQEfY/z/bpuCwlBvvnts6FK197a+LSN4k4TKhV/VUtPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Hptc5V2+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db13ca0363so101497491fa.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713945029; x=1714549829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/Er6GYXVGaNH7JDBFXh3LSSvzcGk3gWsJG0AOM4CTw=;
        b=Hptc5V2+rnXXJTqWm5x2+cw4imBiLFVePvUqflhfHQ8cZF1sfv395V+XBa/xs7y3kg
         v+7r8jKZXa/hoyWrRl+ROXH9O6LWDyCtWBnKlIBSVJ0gv4VxlPuxf/g/xHoUXOEgX3iT
         y2wqeV74cy0r/R8GD5JSO4qHrwoIMWsYv032SHQwkahIXm9mMf9aoFcvzmXI6QmglkZP
         EHTsTrQnqxKFdbXj3AJmv2kboJUQlPkb6t5c5GHQ7OgZsb1d45HdAlLcjRVMVhiZqvgl
         NK1sJTr/yYf6K0Xn+GpyY/07ebCkkurUSMkF5GQd38vS8FPC/oUzOCQFuTPaza+Qto+v
         znOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713945029; x=1714549829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/Er6GYXVGaNH7JDBFXh3LSSvzcGk3gWsJG0AOM4CTw=;
        b=Af+ggiQ9+W1fgO+kz3DY9YlvsO5tf/OliBUVHRFKgQxswJiMpjtGpMwgXoB7gkdtWF
         ge9EOF9qEZqUEgnMMAK2/dqCcNrquLPy2bfXrhfnJoRUJaYqDw8qMidD6lb0zLejbBzB
         gWSzQHkpNpv4ZYhAGHSSdLv7EXoBQgCjj0+pO4TmQ/D27KJsebV053PDfsyZZ8rb5acu
         suZW+yrnz15fG9zlnUtmUNhjJ6PVLa8UtIqxURRXkQ5G9WN+8HzXHoLvohP0N+4OJrDs
         aDozt3WwfKknkcBdU+O2YSthzDH+yr+dHe/cF629dsSJuASwtC5amS4/WQ5CWs3iDc0t
         OxBg==
X-Forwarded-Encrypted: i=1; AJvYcCX01BklYlOL6j4bOHi3Z/ItZmJwKaKuEjK1IaIDtXNjO5k8uyxJIjGo4Z91I28BT0jUfULtcMawup11D1JMHEiaVkn6e9DJgoxGqqL3uFxp
X-Gm-Message-State: AOJu0YxfWmu4rK0BvJ0JNMBJZaebksYOvOf+KDoFwlrmCd4WJF1VeZv3
	YM0nk4sKkv0o4gbOCzAOCy6/ElYIUkj+j0M4rlIO3W1Dt0XepK90n8VnGqHs2lm+2JhBOhqAmqs
	qfqk=
X-Google-Smtp-Source: AGHT+IHIgFIs/HtMioD9CZgIp71sOpN4oVb9nF69ng3WYESdlcm1/4O4CiXzS4QWI0WKmvheznXTlQ==
X-Received: by 2002:a19:7413:0:b0:516:d09b:cbe4 with SMTP id v19-20020a197413000000b00516d09bcbe4mr1517679lfe.53.1713945029369;
        Wed, 24 Apr 2024 00:50:29 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709066b1a00b00a53c746b499sm7957520ejr.137.2024.04.24.00.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 00:50:28 -0700 (PDT)
Date: Wed, 24 Apr 2024 09:50:28 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	Kunwu Chan <chentao@kylinos.cn>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>, 
	Anup Patel <anup@brainfault.org>, Thomas Huth <thuth@redhat.com>, 
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in
 test_vmx_nested_state
Message-ID: <20240424-e31c64bda7872b0be52e4c16@orel>
References: <20240423073952.2001989-1-chentao@kylinos.cn>
 <878bf83c-cd5b-48d0-8b4e-77223f1806dc@web.de>
 <ZifMAWn32tZBQHs0@google.com>
 <20240423-0db9024011213dcffe815c5c@orel>
 <ZigI48_cI7Twb9gD@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZigI48_cI7Twb9gD@google.com>

On Tue, Apr 23, 2024 at 12:15:47PM -0700, Sean Christopherson wrote:
...
> I almost wonder if we should just pick a prefix that's less obviously connected
> to KVM and/or selftests, but unique and short.
>

How about kvmsft_ ? It's based on the ksft_ prefix of kselftest.h. Maybe
it's too close to ksft though and would be confusing when using both in
the same test? I'm not a huge fan of capital letters, but we could also
do something like MALLOC()/CALLOC(). Eh, I don't know. Naming is hard.

Thanks,
drew

