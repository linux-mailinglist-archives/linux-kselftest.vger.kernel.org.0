Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB4147256
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 21:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgAWUFp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 15:05:45 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33835 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgAWUFm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 15:05:42 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so4179420oig.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 12:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyznYH5jQ6Vy0xxWHMJMOnmd05+7Te8s8tuSLOem1vc=;
        b=NEFtawHLgzySPes5yhMKn043r+gEGRFGKhG2aJibWy+YdIIw0CJVynUf/h7t5SDCAn
         YCLGg0okwgHeebwoD2fSmlXxTPzE+8OqgOFxOfSXKIjZI6xLy+zqNphZwdd2Tl3HNdb9
         F+bOjMFMa/rjrcxnOi4Uv4WZy/wdxN2W8Nb0aKewvUoYFlPfCCwLGvMXURaKpP3IPhAy
         Vp7d3t7P3GCpDZy5GL/uWB/BtJVgZPiTYeU3t+OjdbL0MzYC+L/KPsM2qvjVN1iPjPEf
         Ccr0Fq0QlZZfD85rtYSLJWpgC5B4L6fMT7Gk1Ub9GJZ/JSAOlZbDhxtdfgH8LTyMuqxP
         +XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyznYH5jQ6Vy0xxWHMJMOnmd05+7Te8s8tuSLOem1vc=;
        b=eGokjIqcSHCwdif10zxEapkEn2YmlgFjCE5Kb+AscSGmcd814rijywLGCaKaEP1jSP
         JWqYDFjkNmCi843YE7Ukl+oDoaLVWoEdvhg1EgB8BZPpSBZC2YvihItoLoFX3EZ0KyW1
         SGEp9o4VAkiTj/AL6sDKCkJm5RzQ0BfbsFiNx4u2bU4q+aspdy7UzXX1XVkC71cEo+Op
         2Ej3eGqu6rDIeZrvcgFWuK3jecdL0rJbyM0MrpD0HgtVP1wfsmuv1O1BuqfJLGc0Xk0C
         TBef/zsK/8CrUOCS+7vJtb0wrSMXMOSmGwOwSiJ3DmFbRSrYyVmYj/XSL3TOe4bO7rbp
         jcmw==
X-Gm-Message-State: APjAAAXcuE18rxJTLJhdqip569eSJ2yMyFVURtgFWMgqWgU1TRIsXEXP
        2mOSFYNZQkQT8Sm6hTbkUNvOo1ExNy9AFY0CVryDtg==
X-Google-Smtp-Source: APXvYqwiRj0OJ5VwDvTDPamb1fxJTDNZ4OLpyrc6B4XIYJ2G1RIHK15Xy+a0L15Xtv0x5GzGRu8QZoxzo7UGUwseUng=
X-Received: by 2002:aca:b3d6:: with SMTP id c205mr12152720oif.67.1579809941388;
 Thu, 23 Jan 2020 12:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-7-almasrymina@google.com> <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
In-Reply-To: <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 23 Jan 2020 12:05:30 -0800
Message-ID: <CAHS8izNmhxja_0+b2DudpXB+1DQfpnjUu+Qak+wnsApgYrvU=Q@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 23, 2020 at 1:15 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
> For powerpc64, either 16MB/16GB or 2MB/1GB huge pages are supported depending
> on the MMU type (Hash or Radix). I was just running these tests on a powerpc64
> system with Hash MMU and ran into problems because the tests assume that the
> hugepage size is always 2MB. Can you determine the huge page size at runtime?
>

Absolutely. Let me try to reproduce this failure and it should be
fixed in the next patchset version.
