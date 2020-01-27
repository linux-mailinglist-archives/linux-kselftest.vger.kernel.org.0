Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC4214A681
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgA0Ota (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 09:49:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38504 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgA0Ota (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 09:49:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so11647848wrh.5;
        Mon, 27 Jan 2020 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jX8KJNUaBZ7lPrWhJLDlZPLTmG3Da5CIo7TzdsHwbFk=;
        b=h6foz3aEKiBRWiws9pPytTUFKgH3xDbMgDFUFTQ+9iLbz5EcCaXVdGaetsE1PaGm61
         GUQEAcdzTq8ceWlO1UQiahsvWhsxfdKw+a8IqVDnYhtnywLmVaGQjY8nZspFrQK50mC0
         xQTcFk3h9eLo2BX89O1XM2ca3ZIcH0Olf8fwE78AiPZf9od4WLjOUEKnjV3x6ER+/aEr
         YhVa/28zkcj8iPJS8BuFH6o8GoErmzbQHYQ/rjJvDicev9PkZTsGc++kpl9l3g/HHFLT
         yaOMYuxojA0AOXSl/twWBof099F5YF9mxT7UnjM7ipnpj/AcQ9CwmtE0u+yVZaSb0h2z
         OREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jX8KJNUaBZ7lPrWhJLDlZPLTmG3Da5CIo7TzdsHwbFk=;
        b=UrcJKTWjNKcvc8LDirBehYc0T4WorNMHZs9hhat5xGQUF523yBb/R5TpwEiiV800pa
         64hPwaVDOxqizy7xRXgya6h3lZjydh3MODcKiugD/TC9IHBG6JHzzwfUwrOGynq3/pQ8
         QK7nwlx23cDb6sWn7DukHdWYucQwqsxR9csenHSnGoVXhQhM02uU/qd0XyOIbROgErEH
         wKmOEqHnV6fUXFz1XLlZvWpTrGvERj/p++yg64NjSX1LVmxSQHisOHjsoX4q7rTypQpS
         o3wNoFKyxxea4RGDhGQZgaR+teoDuXZdjP4+Gy/pytMX8nVxPjGQ1oIyTdnf4JFrU+NI
         ssgg==
X-Gm-Message-State: APjAAAVqLKYRLdO4vXD7u1vG7WPTILxy2wEXLLJFwA7H1sakWiJ3kUq7
        ih8KXRplmg8JAKaBWSW16JffIGKQAPHvkGiZvlE=
X-Google-Smtp-Source: APXvYqzuUo4DzwKzx54jXhqW/mes8BlzhoUeODxdPF0kk9rT5jKBDQqoOXfDhxLh4Db25Rf8L+pxLvZgr40x5xce4uk=
X-Received: by 2002:a5d:5708:: with SMTP id a8mr21816515wrv.79.1580136568237;
 Mon, 27 Jan 2020 06:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20200108074043.21580-1-svens@linux.ibm.com> <20200108091155.4af8a2c5@gandalf.local.home>
 <20200127132255.GA75877@tuxmaker.boeblingen.de.ibm.com>
In-Reply-To: <20200127132255.GA75877@tuxmaker.boeblingen.de.ibm.com>
From:   Shuah Khan <shuahkhan@gmail.com>
Date:   Mon, 27 Jan 2020 07:49:17 -0700
Message-ID: <CAKocOOM1zNgzY8_LE41HpiYLWNkoWQA7z-DC2ZL1sFHpbVxkkA@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/ftrace: fix glob selftest
To:     Sven Schnelle <svens@linux.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 27, 2020 at 6:23 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>
> Hi Steve,
>
> On Wed, Jan 08, 2020 at 09:11:55AM -0500, Steven Rostedt wrote:
> >
> > Shuah,
> >
> > Want to take this through your tree?
> >
> >  https://lore.kernel.org/r/20200108074043.21580-1-svens@linux.ibm.com
> >
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> As Shuah didn't reply, can you push that through your tree?
>

Hi Sven,

Did you run getmaintainers of this patch? You didn't send this to my
email address listed in the get maintainers file and also didn't cc
linux-kselftest.

I just happen to notice this now. Please resend with steve's
Reviewed-by tag to the recipients suggested by get_maintainers.pl

I will take this through ksleftest tree.

thanks,
-- Shuah
