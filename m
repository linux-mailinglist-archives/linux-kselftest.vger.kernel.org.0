Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8ADD0025
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 19:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfJHRso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 13:48:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35400 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfJHRso (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 13:48:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id p30so8570761pgl.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jfCUvf00utDLqMok3FW/zFyOWNZ71A20p4N5OZxf8XM=;
        b=hsr2lkouEZsK3SdykZlaDK0cspXUj5nZC6Nhx/hSVtJafgpvnj+tYqnPkBbAFuA9k6
         dW5gm/H2b+wwpXbVCfNkKzvhuyhHMsoVrXurq65WD8gcKRJh97UgrzgfsqMVCi82B9By
         +z/yiTm/Ejys0+35GvnbolE7A6/L3IBwnAogV5LzOFuK4bUADPWxg3tEjke2aMWl9Xd6
         PmLgtabboC4jIXKWIMKy/UmNwyFhOKN4nflZf5uszg54kP7Z9Om+sNcp58UeOb2dhsv0
         BQZPiPjN5dm7UNXOues5AvSJeASn5hXui8lkj7v1s1MC3xJnj7FdDeWOLf8Qnf4V72uH
         2X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jfCUvf00utDLqMok3FW/zFyOWNZ71A20p4N5OZxf8XM=;
        b=SbR2o7rFfyGS90rm7OWtfWMDMXL2sCcsDfoNeCjnVHrrqHN6E0U5Gcb0WpdPwMnJYv
         T+AHgDRV0Q35q1zBQMGG1fhPrmW0XojCX372MsHOqNFAnbttsYsloQQV2rZ6AEruc9q6
         7XQwxkB2KNw/DCLW/cE1NW8nP5OK8DQMYB0W1N311Ik4rqYI93NT0YkfmfeFMOt2RQin
         2lO2+Le7YkLwZCKjzEjViZGu2iSB/dqF33nrZXZWOhxQ/MrT2Wm9ggi55WCgk2IE375Q
         wD8pR+N/ki+g25XsIcvA9JFY5FPPTrx3woceFszKkbL9KREVwfmx/tWy8BPJFqT7ePM5
         XJ3w==
X-Gm-Message-State: APjAAAUuXyFUUCIkbNYJ1ixbtjCCXxVkAYElc9wfdH28gSaweGYjtZ1x
        NwX1bdlhDe7iyhmGsAN1YUlUJQ==
X-Google-Smtp-Source: APXvYqymWlK8N7zXz2sJ/F51jwTVbC2MQbu7sNgYWIHbTTXVCA1R2gUDjXvRgkdF1qAnzpwfY7WviQ==
X-Received: by 2002:a63:c641:: with SMTP id x1mr8912872pgg.450.1570556922615;
        Tue, 08 Oct 2019 10:48:42 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id i37sm2561820pje.23.2019.10.08.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 10:48:41 -0700 (PDT)
Date:   Tue, 8 Oct 2019 10:48:37 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked
 list
Message-ID: <20191008174837.GA155928@google.com>
References: <20191007213633.92565-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007213633.92565-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> This change adds a KUnit test for the kernel doubly linked list
> implementation in include/linux/list.h
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).
> 
> This change depends on KUnit, so should be merged via the 'test' branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/Kconfig.debug |  12 +
>  lib/Makefile      |   3 +
>  lib/list-test.c   | 711 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 726 insertions(+)
>  create mode 100644 lib/list-test.c

Also, I think it might be good to make a MAINTAINERs entry for this
test.

Cheers!
