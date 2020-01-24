Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC881490A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 23:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAXWBt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 17:01:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32801 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgAXWBq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 17:01:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so1342470plb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 14:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFmViv0LWpYCZmRZzBXX+e0FCAJTM0WkywcL3e5bisU=;
        b=VKO5iySR05BivpDQZf/VKaq5KXC/T0tXr1RXOxM2Cjjz+2DdsYlr12Q19jKOBereBA
         Nlu9+EGmJw2Ad+dKijIamnqzcecBWtEi2aukIVdIfiK8Fo9SXepfP1CpTyXrn24Ji8M0
         66gHlAJsRUvJpWz/ElEPqWt7DwmZ0aSAfW9AAxSmDzZDKF12hx/+yw/GM4I7nm6Qz5Sz
         o8LNez99DjtBAxQJmSHleGfzM3RFP9Op2Apahq7HW79aRQzo9BYNWyqVYv//HPuTxJVp
         rAF2oyYaLC9GroGIKw30bqpSIMbPq8G9oboKRKYFkVUd4jLdJod1ttB346M86rIfwZLz
         dJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFmViv0LWpYCZmRZzBXX+e0FCAJTM0WkywcL3e5bisU=;
        b=Go7bK6UyIYV+fvEyWtyeTbPVkNOVBN+d5eKzohTrVidApYkH7z4osIAgSMaowd3Uli
         fQYyIXqqbrs3Is5YI8S5GjV8D8wo5bDpVGQj4liNm6Uxp4ONJoEzEVDBKBg0MnS8N1It
         Kdeqq9q/9K0hDc4z0fhD+6F3FuyzOPkUbayckqdObSPl2fNolf44RZXcLZRqVnO5HLIj
         n5tIq1ckWhORNqrqIjHLYS3LdS/CJI+BlO//H9cD+6RYKiQIyrYfdINfLeGxynBrpV08
         /dHSWVBbENN07nAHTxqgi2dHmJr2R85grjHAIbdUvr4U2pEvOqIpb66cg2iHJi0frLeL
         gIOQ==
X-Gm-Message-State: APjAAAUbgnO771MMAfNcP/+JfkxItOu27u4Mo56FcTswV5E/8ijFVlKC
        NFf+umwkEOg2r6tLUoxL9N62J1Dn9ikqjVkfgnG+NQ==
X-Google-Smtp-Source: APXvYqzLJ4DMJP4xsUJ7yoV9hJv9V84tY3jtbZITHm4QWVVh8MDBcRDMqpXCXdzorK9BUvIJ/Al7pvb/nzCerCcaAMg=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr1511151pjt.131.1579903305086;
 Fri, 24 Jan 2020 14:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20200124194507.34121-1-davidgow@google.com>
In-Reply-To: <20200124194507.34121-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 24 Jan 2020 14:01:34 -0800
Message-ID: <CAFd5g46Jym_HX+QmX8ffVYfL1KATNjs9U6sR1Qv9SoVLx5GKDg@mail.gmail.com>
Subject: Re: [PATCH] Fix linked-list KUnit test when run multiple times
To:     David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 24, 2020 at 11:46 AM David Gow <davidgow@google.com> wrote:
>
> A few of the lists used in the linked-list KUnit tests (the
> for_each_entry{,_reverse} tests) are declared 'static', and so are
> not-reinitialised if the test runs multiple times. This was not a
> problem when KUnit tests were run once on startup, but when tests are
> able to be run manually (e.g. from debugfs[1]), this is no longer the
> case.
>
> Making these lists no longer 'static' causes the lists to be
> reinitialised, and the test passes each time it is run. While there may
> be some value in testing that initialising static lists works, the
> for_each_entry_* tests are unlikely to be the right place for it.

Oh good, I am glad we are getting rid of those static variables. (I
thought we already dropped those - whoops.) I think this drops this
last of them, can you confirm David?

Regardless, this patch looks good to me.

> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for taking care of this!
