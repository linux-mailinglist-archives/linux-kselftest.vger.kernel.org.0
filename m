Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0D1AEA0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 07:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgDRFqF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 01:46:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34298 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgDRFqF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 01:46:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id o15so1634545pgi.1;
        Fri, 17 Apr 2020 22:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=McPWGPRYlpQHKYvLXcADFeu7vKVG45vUGz4axl2H35s=;
        b=UHmaF9/DFk9YzqafnwZ8EFukbN3hV+088v1if7+ElEtHxdN8p+z8NJANvChGqj/q3z
         SsWKp9kpLorJXm538hNgSFw7gx4bAIpSLinBtMX30Vs6iu7dWiyeXgmPF0Ac3KNGoEFy
         bo4NUWRWCpE9fATnTkdPwlU8Eb1qdR0O5FcifwCvx2onE20SloxQPXH6o9nW/qq6lZ2V
         KcmtELtsm025VnNuD1w427K8wBPyHQufUizAlDofoYF8IIcQpXXpAEUIydJ048xQUO1j
         UoUYeXMlG89kZhyMUzIWUrcN6Zjz+TUX66Kzh7qdHM0n3hP+QTMI9F8Duk9Ttf5ETpXH
         aYug==
X-Gm-Message-State: AGi0PuZ/sc8Wyi/hahY5nEBwKa5nq3erhOdGcoSVT3wlLkz5V1kpBR8p
        ovyWlXiWQBotwYJu1OXMcOc=
X-Google-Smtp-Source: APiQypIDJkXWaUUj+42W2l4HrEAlUvzSOkUXUp/L5H94len61fRq06Bz467o80GJE5/cGWI+Dx4Wbw==
X-Received: by 2002:a63:4d11:: with SMTP id a17mr6207538pgb.392.1587188764678;
        Fri, 17 Apr 2020 22:46:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c201sm21352804pfc.73.2020.04.17.22.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 22:46:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 867A64028E; Sat, 18 Apr 2020 05:46:02 +0000 (UTC)
Date:   Sat, 18 Apr 2020 05:46:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 1/4] selftests: kmod: Use variable NAME in
 kmod_test_0001()
Message-ID: <20200418054602.GY11244@42.do-not-panic.com>
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 18, 2020 at 01:19:57PM +0800, Tiezhu Yang wrote:
> Use the variable NAME instead of "\000" directly in kmod_test_0001().
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
