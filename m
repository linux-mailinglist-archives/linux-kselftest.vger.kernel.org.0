Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA71A4804
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Apr 2020 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgDJP5c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Apr 2020 11:57:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39991 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDJP5b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Apr 2020 11:57:31 -0400
Received: by mail-io1-f66.google.com with SMTP id w1so2164914iot.7
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Apr 2020 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cmgNQ18bQZuP/PsrCAMjWp3cC4Z/HjH3ZP68Agn9Q9I=;
        b=Zh7jbnBmhR1yBRFDVmFJ4KzmlptydnzXIJnoy/ZUkT8LIveuLD6PNl3ZN/AumjpZNj
         /ATLX1BRoGcA0s6io0u9kjBjnBW3bIgMcCaaAUdrJIxaFDbiOm6W8xpYL04XoFV1Z39G
         W0Tj9sIIATI2ED9zRyEmQ/clSfVdQcTZvUcgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmgNQ18bQZuP/PsrCAMjWp3cC4Z/HjH3ZP68Agn9Q9I=;
        b=qdEnQKT8uvo22v2X7pwucOcT1ssX/Vw5m8DOrXVSkrzNjhVebvB8qbsjP2ReGuwcYS
         2ntJWDWWwulssWUin/9HkCLwbCcFepnI5gTkBd8BwJs2jaECWYT6c+8JWRTA8kOEGsuE
         3M4CPDnJZLX3PSwcLi4wgIIZ/EYNn9ZRMiO6ZWju8EC+IlEzNTlkqczG5+uPnjnK+yeF
         E7PeyjnHLhzmBEkUeZLfeblNa/NAKIZPm3eV5xNTSwaagrEwlkj/q9MRvmBkHI0gB3ZI
         X0WiPRUBy2oIDQ7PNQJLwS0GVk5IlYmEA7RzjdgXfwUN9erFflfzpQr/xcvbPGawORBI
         VkYg==
X-Gm-Message-State: AGi0PuZoCEkTbodCuaBqPxTJCcAw2QC3i/PrtZgFCtjj/+EZEgbK4abu
        OBjJYeI9bak5HverJUM9KFyQ7w==
X-Google-Smtp-Source: APiQypI+9ul4Vwa9aPByPnHLiWGHPAk+YdhmBpUDxRSELcFECrdIik4lACPB3aKsG1Pr8V2Ff1JQjA==
X-Received: by 2002:a02:c9cb:: with SMTP id c11mr4950972jap.93.1586534249733;
        Fri, 10 Apr 2020 08:57:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u4sm685124iog.21.2020.04.10.08.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 08:57:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] selftests: vm: Do not override definition of ARCH
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        mhiramat@kernel.org, aneesh.kumar@linux.ibm.com,
        kamalesh@linux.vnet.ibm.com, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1580367152.git.sandipan@linux.ibm.com>
 <471a73600bf9f59a59484726f50f81d7f54f4b2f.1580367152.git.sandipan@linux.ibm.com>
 <87lfp9zvl4.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dbaeecdc-6145-50ca-b874-9f3ed11c927b@linuxfoundation.org>
Date:   Fri, 10 Apr 2020 09:57:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87lfp9zvl4.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/20 7:49 PM, Michael Ellerman wrote:
> Sandipan Das <sandipan@linux.ibm.com> writes:
>> Independent builds of the vm selftests is currently broken
>> because commit 7549b3364201 overrides the value of ARCH with
>> the machine name from uname. This does not always match the
>> architecture names used for tasks like header installation.
>>

In the interest not adding more delays to this patch, I fixed up
the commit log for the following error and applied it. I hope to
send this up for next rc.

ERROR: Please use git commit description style 'commit <12+ chars of 
sha1> ("<title line>")' - ie: 'commit 7549b3364201 ("selftests: vm: 
Build/Run 64bit tests only on 64bit arch")'
#93:
because commit 7549b3364201 overrides the value of ARCH with


The fixed up now looks as follows:

Independent builds of the vm selftests is currently broken because
commit 7549b3364201 ("selftests: vm: Build/Run 64bit tests only on
64bit arch") overrides the value of ARCH with the machine name from
uname. This does not always match the architecture names used for
tasks like header installation.

Please make sure to run checkpatch with --strict to catch these
kinds of errors in the future.

thanks,
-- Shuah
