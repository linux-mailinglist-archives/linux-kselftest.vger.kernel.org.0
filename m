Return-Path: <linux-kselftest+bounces-29733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF768A6EB2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 09:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48621890F7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C9A253B52;
	Tue, 25 Mar 2025 08:12:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DD1A5B89;
	Tue, 25 Mar 2025 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890323; cv=none; b=ZpWN2UI48qcAt9Ofqub5+6HFPHncZ6Arvd6UBdpZ44YuL2nbe+eL5GY0baOLDQQAqU2+DX1KOw3nloQngoYDGXDo6BTwP6h0wgPG3VSPabUxpgwiBMWDDcdAQKOKSUZXtCFeFqDEOKeN/V/vZIllVhLmpXquSbhgxWcopIyZ/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890323; c=relaxed/simple;
	bh=l3pgQA1U4vKTNf/KxkOtihkRRMDf1d1IdFUh6Y4HDO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLYu0jEP6ObqdYkvNy6Q8zvyNfKHguBM/KpHU94k9GdvAZjnjBCcP63I0o+bwGqYthdOBiZLwxDlR3Q/X9PsKVuwzjZjdtRF9a6bOebe/JXba8V3vo7QiXtjDZmpiYTh2nAdo7J10vwxSrQq8seTOD2XxbO2m/RM0N6aycV2Ga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-474f0c1e1c6so81469161cf.1;
        Tue, 25 Mar 2025 01:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742890320; x=1743495120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZC0G6MVz9EIHwJ/4QeHnpY6DgPswOWy+fhpxGY/Dqk=;
        b=esD6r3dCfCCrZ7lGCP6tBOZoZ94O5w7ufJBNwyTrAMLwqeDTpDqT+472hNc9MOcDCE
         2n+nzDtGrkdBeVlmAbEfv9wUISjYuaIsfIK+V071FttbhsNt4zqWHSVaiaW+ViPIL68R
         D0KUSbAec8MHIBXOPG3PdyoCtp7HXVturLHZyZR0yPTRlnK38czfXm9l4XxImwMlryBl
         lmMElq1Mr7gv0rag2mkYzSCoshxVSgi8kvCF244sGcDx0WLinDIMiLrXiKkgR3lIPWlf
         plr4FdqlD7MTkpG62D5oI/SOnnw0GrI9yu9olGjrq21BXVVYh9tTqlNKznNijcQY26Pp
         jP6A==
X-Forwarded-Encrypted: i=1; AJvYcCVVvOuGAR0GgUHUKVxqoTgu9IsgXdjrUbSThu7s8SJlOYF/Qnp2kSHGE4Upth5IcyZvgLpkFybvdjc=@vger.kernel.org, AJvYcCVijNCbH65JH+ME6aId0EPCw+P97hQwzcwnkotgkX6ewbgyflX75TIPJv7tKaxHEA+b1VWNoNfVbHmPiQfdiAkW@vger.kernel.org, AJvYcCWV84DJFX5NlI3BKvJmMITpIZRtNGUsThFXLkevsP/xXgjHGO0FE8oj4QiFAACvASUHbRG6e+ZF1GIvOo9OUpGzZrTd@vger.kernel.org, AJvYcCXXxfISxwL0Q0fRm3/MKBikJiBgrUyumjbkixzXBLaWmQtjyyojGLzRhVoeQO7dXKaCCNPaHm5pWwMCghDi@vger.kernel.org
X-Gm-Message-State: AOJu0YxshZfS2oE0fIQlKNnkn57g+qCykK1R8WIVTnlZ6wmebgXNkdOR
	JEyprjlP2bPokexnO822vbKkcSHCOXWpIB1fC05X/EWjRt9WBSpIFDkuaHQ+
X-Gm-Gg: ASbGncv4+JrXwiM/Lmz8JSLrzpV/GAQrd2nPYAeUjkI09nZX29uJCjWx7nqt7LIRt3p
	D7WQj29CriY22oc/E9dHasWoG8jLicR/T3jUt3MXgnCQ1NZxI36fpVw9fEfhm/QD//8Ni0lYwDT
	UYF9mDVtZOnS3B2K9qWsQN5JXYe5Zen7J6h56yM8zGbKW3gZ3DRklF/OtH2V8y8fmSjPNgaNm/5
	n/73Uj9XjSzgdcGw5YQXSFZOa2WgT7Z+CoAvC/VccTJM60XYSCS1QKp6REF4TrCJoUhoHZzOiWm
	dv3MscQYXpJk1DKy7RpC41B9Xuy3QaLnh19q/nQntHNm2t0z/mU+leyjIZ/siIdaDh1G3V/Fpox
	gwLzUwo4oA6E=
X-Google-Smtp-Source: AGHT+IHRuYBdgv5CMYIjs0GWcwd0bsBW/6PeQyINMZ+bSfilx4dZBJ1dVxL8R5V3KYfbWDW4Zckcrg==
X-Received: by 2002:a05:6214:f62:b0:6d4:1680:612d with SMTP id 6a1803df08f44-6eb3f1a731bmr234175116d6.0.1742890320257;
        Tue, 25 Mar 2025 01:12:00 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0efd9sm54173736d6.11.2025.03.25.01.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 01:12:00 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c54b651310so810212485a.0;
        Tue, 25 Mar 2025 01:11:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1V22TBGt0T1NkQmeL2wLhr2iq4DfHy8jrUIqM8KobF1As4PMNGKfQByaRGWe+z8gJsFRL9hU6vjlgRr4YXgug@vger.kernel.org, AJvYcCW+cNo86oSHm8ACu7lM9tDRFtNO4MCz5UQPtA2QshYkksT+sTgleO0qJr8pIFb2OOdFyrEyaZjH85IT6/sB@vger.kernel.org, AJvYcCWRkhrlzTB85NNdk9mmr4b/6dm9Ie0wmZZNxiuLPK49S53B+ozDb+I8wzFJDLBBw9Ploc9WjCoI6KRfvR3RclgEaNZp@vger.kernel.org, AJvYcCXp2r9VHiZuppe6rkoXeYJ80itSiktOJRbsNUI55o+e+tSrbDyuQTvAKhWtqwAuBcf8+Kz/5YdNlic=@vger.kernel.org
X-Received: by 2002:a05:6102:5241:b0:4c4:dead:59a3 with SMTP id
 ada2fe7eead31-4c50d496a1cmr12372942137.2.1742889884357; Tue, 25 Mar 2025
 01:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219153938.24966-1-boqun.feng@gmail.com> <20250219153938.24966-11-boqun.feng@gmail.com>
In-Reply-To: <20250219153938.24966-11-boqun.feng@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Mar 2025 09:04:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoE7ZunbEn2lIWdcQ0LTcplBdC2QyWAfIuaecNnkHmcPWNAR1fB65H0kiQ
Message-ID: <CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com>
Subject: Re: [PATCH rcu 10/11] srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing
To: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Huth <thuth@redhat.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Valentin Schneider <vschneid@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Boqun, Paul,

On Wed, 19 Feb 2025 at 16:44, Boqun Feng <boqun.feng@gmail.com> wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> The srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe() functions
> map to __srcu_read_lock() and __srcu_read_unlock() on systems like x86
> that have NMI-safe this_cpu_inc() operations.  This makes the underlying
> __srcu_read_lock_nmisafe() and __srcu_read_unlock_nmisafe() functions
> difficult to test on (for example) x86 systems, allowing bugs to creep in.
>
> This commit therefore creates a FORCE_NEED_SRCU_NMI_SAFE Kconfig that
> forces those underlying functions to be used even on systems where they
> are not needed, thus providing better testing coverage.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Thanks for your patch, which is now commit 536e8b9b80bc7a0a ("srcu:
Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing") in linus/master

> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -65,6 +65,17 @@ config TREE_SRCU
>         help
>           This option selects the full-fledged version of SRCU.
>
> +config FORCE_NEED_SRCU_NMI_SAFE
> +       bool "Force selection of NEED_SRCU_NMI_SAFE"

What am I supposed to answer here? "n" I guess.
What about distro and allmodconfig kernels?

> +       depends on !TINY_SRCU
> +       select NEED_SRCU_NMI_SAFE
> +       default n
> +       help
> +         This option forces selection of the NEED_SRCU_NMI_SAFE
> +         Kconfig option, allowing testing of srcu_read_lock_nmisafe()
> +         and srcu_read_unlock_nmisafe() on architectures (like x86)
> +         that select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.

Perhaps this should depend on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS?

> +
>  config NEED_SRCU_NMI_SAFE
>         def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

