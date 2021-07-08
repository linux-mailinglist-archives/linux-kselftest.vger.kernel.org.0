Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8363C19EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhGHTke (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 15:40:34 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:43618 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGHTke (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 15:40:34 -0400
Received: by mail-pj1-f46.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso4635453pjp.2;
        Thu, 08 Jul 2021 12:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FD/o6GkCz5FF2ZmMSSn4z7q5kmVT9z2G4ulQiCHHU8s=;
        b=T9mw4ewNGrRmSJv8tooKDENemD+HD7lrZ4LhF0l8jCBn3yNEASjbVWAXm7PwvVklnY
         Mt7WWXN6YgDcqUmx44xXSDd1K67UuCfDXfdN+nh7EJsimJkGFvunLUb5IL0zKyjv7BJd
         jpczjVJh1e4KSSxcfpFX4av6BmdVov3Xq37C5yHGV63gK2hi7NqskUmaKeFNyUoxhSN+
         ngLZgrGzm22z5D0eCoc6waJN5pV/a9Cg8l8Oup4KWcoNyVrUZWEEtFO57jDyRqxOt2Uf
         3CXer7gqLrvWDXOSiakl0KWXj0TKUecZ0cwU7xcRvxbSLCxepHs4WlCeREV5FAUFfZoM
         wrwA==
X-Gm-Message-State: AOAM533genHlXYBvN8ouFzsjXF2Otf4SKm6DLG8JQHiTd1F1kiy4l5bv
        zKGT4AyzMWWQ8k/IlUrJ56Q=
X-Google-Smtp-Source: ABdhPJyj6gQbslJuJzCqRoefkKNMvSYEGtI2HHVYwAqNmwYAqxz/l/u4ySApR2gIxQ4BewG5TdLmhQ==
X-Received: by 2002:a17:90a:3f87:: with SMTP id m7mr6512103pjc.128.1625773071394;
        Thu, 08 Jul 2021 12:37:51 -0700 (PDT)
Received: from garbanzo ([191.96.120.45])
        by smtp.gmail.com with ESMTPSA id 5sm4118693pgv.25.2021.07.08.12.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:37:50 -0700 (PDT)
Date:   Thu, 8 Jul 2021 12:37:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Bradley M. Kuhn" <bkuhn@ebb.org>,
        Greg KH <gregkh@linuxfoundation.org>, tglx@linutronix.de,
        akpm@linux-foundation.org, shuah@kernel.org, rafael@kernel.org,
        rgoldwyn@suse.com, kuno@frob.nl, fontana@sharpeleven.org,
        Ciaran.Farrell@suse.com, Christopher.DeNicolo@suse.com, hch@lst.de,
        corbet@lwn.net, linux@leemhuis.info, ast@kernel.org,
        andriin@fb.com, daniel@iogearbox.net, atenart@kernel.org,
        alobakin@pm.me, weiwan@google.com, ap420073@gmail.com,
        tj@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        keescook@chromium.org, jikos@kernel.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-spdx@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
Message-ID: <20210708193746.7e2dbpgs33cl73wx@garbanzo>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
 <YOaZohB/2Z3x5grc@kroah.com>
 <YOcSwXkpzAFGucXM@ebb.org>
 <YOcakETswyEN58j6@kroah.com>
 <YOc7dgBq/N5vDjhx@ebb.org>
 <20210708150158.08ba548c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210708150158.08ba548c@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 08, 2021 at 03:01:58PM -0400, Steven Rostedt wrote:
> On Thu, 8 Jul 2021 10:52:54 -0700
> "Bradley M. Kuhn" <bkuhn@ebb.org> wrote:
> 
> > Joe Perches wrote:
> > >>> You can ask but it's the submitter's choice to license their code however
> > >>> they desire.  
> > 
> > … to which I'd add, as long as the license is GPLv2-only-compatible, which of
> > course (GPLv2-only|copyleft-next) is.
> 
> I agree with Joe on this, but I have to ask; What happens when someone
> makes a change to this file? The default kernel license is GPL-v2. Does this
> change automatically become the same as the file itself, or is the new
> change under the dual license?
> 
> I've made changes to code that had a dual license that wasn't GPL
> compatible, and the company involved asked me to sign off on the other
> license (which I did).

The Signed-off-by tag implies you are making a contribution under the
same license as the license file states. The more people are aware of
this fact, the better, and its then why we made DCO a public thing and
now other projects embrace it.

  Luis
